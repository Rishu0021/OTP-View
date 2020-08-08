//
//  ViewController.swift
//  OTP View
//
//  Created by Rishu Gupta on 08/08/20.
//  Copyright © 2020 Rishu Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewOTP: RGOTPView!
    @IBOutlet weak var buttonSubmit: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Theme.Colors.BackgroundPrimary
    }


    @IBAction func buttonHandlerSubmit(_ sender: Any) {
        /// Use below line to display warning or error with color to otp fields
        // self.viewOTP.setAllFieldColor(isWarningColor: true, color: Theme.Colors.Error)
        
        /// Used to get otp text from fields
        let otp = self.viewOTP.getOTP()
        if otp.count < 4 {
            self.viewOTP.setAllFieldColor(isWarningColor: true, color: Theme.Colors.Error)
            print("Please enter valid 4 digit OTP.")
            return
        }
        print("Entered OTP:", otp)
    }
}

