//
//  RGOTPTextField.swift
//  OTP View
//
//  Created by Rishu Gupta on 20/07/20.
//

import UIKit

class RGTextField: UITextField, UITextFieldDelegate {
    
    @IBInspectable
    public var placeholderColor : UIColor = Theme.Colors.TextSecondary {
        didSet {
            self.setPlaceholderColor(self.placeholderColor)
        }
    }
            
    @IBInspectable
    public var borderWidth: CGFloat = 1.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable
    public var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
        
    @IBInspectable
    var hasError: Bool = false {
        didSet {
            if (hasError) {
                self.layer.borderColor = Theme.Colors.Error.cgColor //error color
            } else {
                self.layer.borderColor = borderColor.cgColor //passive color
            }
        }
    }
        
    override func awakeFromNib() {
        // Setup Bottom-Border
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    func commonInit() {
        self.delegate = self
        self.textColor = Theme.Colors.TextPrimary
        self.font = Theme.Font.RegularFont
        self.tintColor = .black
        self.setPlaceholderColor(self.placeholderColor)
    }
    
    private func setPlaceholderColor(_ color : UIColor) {
        let rawString = attributedPlaceholder?.string != nil ? attributedPlaceholder!.string : ""
        let str = NSAttributedString(string: rawString, attributes: [NSAttributedString.Key.foregroundColor : color])
        attributedPlaceholder = str
    }
    
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        superview?.endEditing(true)
        return false
    }
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.placeholderColor = Theme.Colors.TextPlaceholder
        self.hasError = false
    }
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.placeholderColor = Theme.Colors.TextSecondary
        self.hasError = false
    }
    
}


// MARK:- TextField with Customizable Corner
@IBDesignable
class RGTextFieldWithCorner: RGTextField {
    
    //MARK:- Corner Layer Properties
    private var enabledCorners = CACornerMask()
    
    @IBInspectable
    public var bezelArcSize: CGFloat = 20.0 {
        didSet {
            updateCorners()
        }
    }
        
    @IBInspectable
    public var topLeftBezel: Bool = true {
        didSet {
            topLeftBezel ? addCorner(corner: .layerMinXMinYCorner) : removeCorner(corner: .layerMinXMinYCorner)
        }
    }

    @IBInspectable
    public var topRightBezel: Bool = false {
        didSet {
            topRightBezel ? addCorner(corner: .layerMaxXMinYCorner) : removeCorner(corner: .layerMaxXMinYCorner)
        }
    }

    @IBInspectable
    public var bottomLeftBezel: Bool = false {
        didSet {
            bottomLeftBezel ? addCorner(corner: .layerMinXMaxYCorner) : removeCorner(corner: .layerMinXMaxYCorner)
        }
    }
    
    @IBInspectable
    public var bottomRightBezel: Bool = true {
        didSet {
            bottomRightBezel ? addCorner(corner: .layerMaxXMaxYCorner) : removeCorner(corner: .layerMaxXMaxYCorner)
        }
    }
        
    
    @IBInspectable
    public var leftImage: UIImage? {
        didSet {
            updateLeftView()
        }
    }

    @IBInspectable
    public var rightImage: UIImage? {
        didSet {
            updateRightView()
        }
    }
    
    @IBInspectable public var padding: CGFloat = 16
    
    @IBInspectable public var iconSize: CGFloat = 30
            

    // Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    

    public override func commonInit() {
        super.commonInit()
        
        self.backgroundColor = Theme.Colors.TextBackground
        self.updateLeftView()
        self.updateCorners()
        
        self.addShadow(offset: CGSize(width: 1.0, height: 1.0), color: .gray, opacity: 0.6, radius: 2.0)
    }
    
    private func updateLeftView() {
        if let image = leftImage {
            leftViewMode = .always
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: iconSize, height: iconSize))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            leftView = imageView
        } else {
            leftViewMode = .never
            leftView = nil
        }
    }
    
    private func updateRightView() {
        if let image = rightImage {
            rightViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: iconSize, height: iconSize))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            rightView = imageView
        } else {
            rightViewMode = .never
            rightView = nil
        }
    }

    
    // Setup Corner layer
    private func addCorner(corner: CACornerMask) {
        enabledCorners.formUnion(corner)
        updateCorners()
    }
    
    private func removeCorner(corner: CACornerMask) {
        enabledCorners.subtract(corner)
        updateCorners()
    }
    
    private func updateCorners() {
        self.layer.cornerRadius = bezelArcSize
        self.layer.maskedCorners = enabledCorners
        self.setNeedsDisplay()
    }

    override var bounds: CGRect {
        didSet {
            updateCorners()
        }
    }
    
    // Provides left padding for left view
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += padding
        return textRect
    }
    
    // Provides right padding for right view
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= padding
        return textRect
    }
    
    private var height : CGFloat {
        let height: CGFloat = (leftImage != nil) ? (iconSize + padding) : padding
        return height
    }
    private var inset : CGFloat {
        guard self.leftImage != nil || self.rightImage != nil else { return (padding*2) }
        
        var inset: CGFloat = 0.0
        if leftImage != nil && rightImage != nil {
            inset += (padding * 2)
            return (inset + height)
        }
        if leftImage != nil {
            inset += 8.0
        }
        if rightImage != nil {
            inset += (padding * 2)
        }
        return (inset + height)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + height, y: bounds.origin.y, width: bounds.width - inset, height: bounds.height)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + height, y: bounds.origin.y, width: bounds.width - inset, height: bounds.height)
    }
    
}
