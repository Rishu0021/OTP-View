//
//  RGOTPView.swift
//  OTP View
//
//  Created by Rishu Gupta on 20/07/20.
//

import UIKit

protocol RGOTPViewDelegate: class {
    func didChangeValidity(isValid: Bool)
}

@IBDesignable
open class RGOTPView: UIView {
    
    weak var delegate: RGOTPViewDelegate?
    
    /// Number of fields
    @IBInspectable public var numberOfFields: Int = 4 {
        didSet {
            self.addOTPFields()
            self.setNeedsDisplay()
        }
    }
    /// Spacing between tags
    @IBInspectable public var fieldSpacing: CGFloat = 16.0 {
        didSet {
            self.addOTPFields()
            self.setNeedsDisplay()
        }
    }
    /// Spacing between tags
    @IBInspectable public var fieldWidth: CGFloat = 40.0 {
        didSet {
            self.addOTPFields()
            self.setNeedsDisplay()
        }
    }
    /// Text font
    @IBInspectable public var textFont: UIFont = UIFont.systemFont(ofSize: Theme.Font.sizeExtraLarge) {
        didSet {
            self.addOTPFields()
            self.setNeedsDisplay()
        }
    }
    /// Text color
    @IBInspectable public var textColor : UIColor = Theme.Colors.TextPrimary {
        didSet {
            self.addOTPFields()
            self.setNeedsDisplay()
        }
    }
    /// Backgound color
    @IBInspectable public var textBackgroundColor : UIColor = #colorLiteral(red: 0.9863741994, green: 0.9797278047, blue: 0.9795569777, alpha: 1) {
        didSet {
            self.addOTPFields()
            self.setNeedsDisplay()
        }
    }
    /// Text active border color
    @IBInspectable public var activeBorderColor : UIColor = #colorLiteral(red: 0.5799676776, green: 0.5800538063, blue: 0.5799488425, alpha: 1) {
        didSet {
            self.addOTPFields()
            self.setNeedsDisplay()
        }
    }
    /// Text inactive border color
    @IBInspectable public var inactiveBorderColor : UIColor = UIColor.clear {
        didSet {
            self.addOTPFields()
            self.setNeedsDisplay()
        }
    }
    /// Text border width
    @IBInspectable public var borderWidth : CGFloat = 1.0 {
        didSet {
            self.addOTPFields()
            self.setNeedsDisplay()
        }
    }
    /// Text border width
    @IBInspectable public var cornerRadius : CGFloat = 12.0 {
        didSet {
            self.addOTPFields()
            self.setNeedsDisplay()
        }
    }
    
    /// Shows warning color
    var showsWarningColor = false
    private let otpStackView = UIStackView()
    private var textFieldsCollection: [RGOTPTextField] = []
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
        
    private func commonInit() {
        self.backgroundColor = .clear
        
        // Setup StackView
        self.otpStackView.backgroundColor = .clear
        self.otpStackView.isUserInteractionEnabled = true
        self.otpStackView.translatesAutoresizingMaskIntoConstraints = false
        self.otpStackView.contentMode = .center
        self.otpStackView.distribution = .fillEqually
        self.otpStackView.spacing = fieldSpacing
        
        self.addSubview(otpStackView)
        self.otpStackView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        self.otpStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.otpStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.addOTPFields()
    }
    
    // Adding each OTP Field to stack view
    private func addOTPFields() {
        if self.textFieldsCollection.isEmpty == false {
            self.textFieldsCollection.removeAll()
            self.otpStackView.removeAllSubviews()
        }
        for index in 0..<numberOfFields {
            let field = RGOTPTextField()
            setupTextField(field)
            textFieldsCollection.append(field)
            //Adding a marker to previous field
            index != 0 ? (field.previousTextField = textFieldsCollection[index-1]) : (field.previousTextField = nil)
            //Adding a marker to next field for the field at index-1
            index != 0 ? (textFieldsCollection[index-1].nextTextField = field) : ()
        }
        //setting first field as firstResponder
        textFieldsCollection[0].becomeFirstResponder()
    }
    
    private func setupTextField(_ textField: RGOTPTextField) {
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.otpStackView.addArrangedSubview(textField)
        textField.centerYAnchor.constraint(equalTo: self.otpStackView.centerYAnchor).isActive = true
        textField.heightAnchor.constraint(equalTo: self.otpStackView.heightAnchor).isActive = true
        textField.widthAnchor.constraint(equalToConstant: fieldWidth).isActive = true
        
        textField.backgroundColor = textBackgroundColor
        textField.textAlignment = .center
        textField.adjustsFontSizeToFitWidth = false
        textField.font = textFont
        textField.textColor = textColor
        textField.keyboardType = .numberPad
        
        textField.bezelArcSize = cornerRadius
        textField.topLeftBezel = true
        textField.bottomRightBezel = true
        textField.borderWidth = borderWidth
        textField.borderColor = inactiveBorderColor
    }
    
    func checkForValidity() {
        for fields in textFieldsCollection {
            if (fields.text == "") {
                delegate?.didChangeValidity(isValid: false)
                return
            }
        }
        delegate?.didChangeValidity(isValid: true)
    }
    
    func getOTP() -> String {
        var OTP = ""
        for textField in textFieldsCollection {
            OTP += textField.text ?? ""
        }
        return OTP
    }
    
    func setOTP(otp : String) {
        let otpArr = otp.map { String($0)}
        for (index, textField) in textFieldsCollection.enumerated() {
            textField.text = otpArr[index]
            textField.resignFirstResponder()
        }
    }

    func setAllFieldColor(isWarningColor: Bool = false, color: UIColor) {
        for textField in textFieldsCollection {
            textField.borderColor = color
        }
        showsWarningColor = isWarningColor
    }
}

extension RGOTPView: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if showsWarningColor {
            setAllFieldColor(color: inactiveBorderColor)
            showsWarningColor = false
        }
        (textField as? RGOTPTextField)?.borderColor = activeBorderColor
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        (textField as? RGOTPTextField)?.borderColor = inactiveBorderColor
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
        
        guard let textField = textField as? RGOTPTextField else { return true }
        
        if (range.length == 0) {
            
            if textField.nextTextField == nil {
                textField.resignFirstResponder()
            } else {
                textField.nextTextField?.becomeFirstResponder()
            }
            textField.text? = string
            checkForValidity()
            return false
            
        }
        else if (range.length == 1) {
            
            textField.previousTextField?.becomeFirstResponder()
            textField.text? = ""
            checkForValidity()
            return false
            
        }
        return true
    }
    
}


// MARK:- OTP TextField
class RGOTPTextField: RGTextFieldWithCorner {
    
    var previousTextField: RGOTPTextField?
    var nextTextField: RGOTPTextField?
    
    override public func deleteBackward() {
        if text == "" {
            previousTextField?.becomeFirstResponder()
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }

}
