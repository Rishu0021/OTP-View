//
//  Theme.swift
//  OTP View
//
//  Created by Rishu Gupta on 20/07/20.
//

import UIKit

struct Theme {
    
    struct Colors {
        static let Primary = UIColor(named: "PrimaryColor") ?? #colorLiteral(red: 0.9348487258, green: 0.2423158586, blue: 0.3526790142, alpha: 1)
        static let Secondary = UIColor(named: "SecondaryColor") ?? #colorLiteral(red: 0.9499316812, green: 0.4255635738, blue: 0.1344385445, alpha: 1)
        static let Accent = UIColor(named: "AcentColor") ?? #colorLiteral(red: 0.8840000033, green: 0.8100000024, blue: 0.7570000291, alpha: 1)
        
        static let Error = UIColor(named: "ErrorColor") ?? #colorLiteral(red: 1, green: 0.4120000005, blue: 0.3580000103, alpha: 1)
        static let Success = UIColor(named: "SuccessColor") ?? #colorLiteral(red: 0.2370000035, green: 0.7990000248, blue: 0.476000011, alpha: 1)
        static let Warning = UIColor(named: "WarningColor") ?? #colorLiteral(red: 1, green: 0.7459999919, blue: 0.3120000064, alpha: 1)
        static let TextActiveBorder = UIColor(named: "TextActiveColor") ?? #colorLiteral(red: 0.2860000134, green: 0.3140000105, blue: 0.3409999907, alpha: 1)
        static let TextInactiveBorder = UIColor(named: "TextInactiveColor") ?? #colorLiteral(red: 0.8080000281, green: 0.8309999704, blue: 0.8550000191, alpha: 1)
        
        static let TextPrimary = UIColor(named: "TextPrimaryColor") ?? #colorLiteral(red: 0.2595806718, green: 0.2596316338, blue: 0.2595774531, alpha: 1)
        static let TextSecondary = UIColor(named: "TextSecondaryColor") ?? #colorLiteral(red: 0.3582906723, green: 0.3583576083, blue: 0.3582865, alpha: 1)
        static let TextTertiary = UIColor(named: "TextTertiaryColor") ?? #colorLiteral(red: 0.7419999838, green: 0.7419999838, blue: 0.7419999838, alpha: 1)
        static let TextQuaternary = UIColor(named: "TextQuaternaryColor") ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let TextPlaceholder = UIColor(named: "TextPlaceholderColor") ?? #colorLiteral(red: 0.8730638623, green: 0.873214066, blue: 0.8730544448, alpha: 1)
                
        
        static let TextBackground = UIColor(named: "TextBackgroundColor") ?? #colorLiteral(red: 0.9888326526, green: 0.9797794223, blue: 0.9794719815, alpha: 1)
        static let ButtonBackground = UIColor(named: "ButtonBackgroundColor") ?? #colorLiteral(red: 0.8064273, green: 0.8065667748, blue: 0.8064184785, alpha: 1)
        static let BackgroundPrimary = UIColor(named: "BackgroundPrimaryColor") ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let BackgroundSecondary = UIColor(named: "BackgroundSecondaryColor") ?? #colorLiteral(red: 0.8591374159, green: 0.8871019483, blue: 0.9180325866, alpha: 0.5972986356)
        
        static let Selection = UIColor(named: "SelectionColor") ?? #colorLiteral(red: 0.90200001, green: 0.90200001, blue: 0.90200001, alpha: 1)
        static let Separator = UIColor(named: "SeparatorColor") ?? #colorLiteral(red: 0.7419999838, green: 0.7419999838, blue: 0.7419999838, alpha: 1)
                
    }
    
    struct Font {
        static let sizeSmall: CGFloat = 11
        static let sizeMedium: CGFloat = 13
        static let sizeRegular: CGFloat = 15
        static let sizeLarge: CGFloat = 17
        static let sizeExtraLarge: CGFloat = 20
        
        static let SmallFont : UIFont = UIFont(name: "Avenir-Roman", size: sizeSmall) ?? UIFont.systemFont(ofSize: sizeSmall)
        static let MediumFont : UIFont = UIFont(name: "Avenir-Roman", size: sizeMedium) ?? UIFont.systemFont(ofSize: sizeMedium)
        static let RegularFont : UIFont = UIFont(name: "Avenir-Roman", size: sizeRegular) ?? UIFont.systemFont(ofSize: sizeRegular)
        static let LargeFont : UIFont = UIFont(name: "Avenir-Roman", size: sizeLarge) ?? UIFont.systemFont(ofSize: sizeLarge)
        static let ExtraLargeFont : UIFont = UIFont(name: "Avenir-Roman", size: sizeExtraLarge) ?? UIFont.systemFont(ofSize: sizeExtraLarge)
    }
}
