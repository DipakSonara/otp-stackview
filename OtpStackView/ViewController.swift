//
//  ViewController.swift
//  OtpStackView
//
//  Created by Dipak Sonara on 26/10/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var otpView: ContainerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


extension ViewController: ContainerViewDelegate {
    func otpEntered(_ otp: String) {
        print(otp)
    }
}
