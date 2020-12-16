//
//  ContainerView.swift
//  OtpStackView
//
//  Created by Dipak Sonara on 26/10/20.
//

import UIKit

protocol ContainerViewDelegate: NSObjectProtocol {
    func otpEntered(_ otp: String)
}

@IBDesignable class ContainerView: UIView {
    

    @IBInspectable var digits: Int = 4 {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var padding: CGFloat = 10.0 {
        didSet {
            setup()
        }
    }
    
    weak var containerDelegate: ContainerViewDelegate?
    var textFieldArray = [CustomTextField]()
    var otp = ""
    
    private func setup() {
        
        
        //Stack View
        let stackView   = OTPView()
        stackView.numberOfOTPdigit = digits
        stackView.frame = self.frame
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = .fillEqually
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = padding
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        stackView.isUserInteractionEnabled = true
        stackView.contentMode = .center
        stackView.setTextFields()
        self.addSubview(stackView)
        
        //Constraints
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.addConstraint(NSLayoutConstraint(item: stackView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
    }
    
}


class OTPView: UIStackView {

    var textFieldArray = [CustomTextField]()
    var numberOfOTPdigit = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTextFields()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setTextFields()
    }
    
    func setTextFields() {
        for i in 0..<numberOfOTPdigit {
            let field = CustomTextField()
            field.underlineColor = .lightGray
            field.underlineEditingColor = .black
            textFieldArray.append(field)
            addArrangedSubview(field)
            field.delegate = self
            
            i != 0 ? (field.previousTextField = textFieldArray[i-1]) : ()
            i != 0 ? (textFieldArray[i-1].nextTextFiled = textFieldArray[i]) : ()
        }
    }
}

extension OTPView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let field = textField as? CustomTextField else {
            return true
        }
        if !string.isEmpty {
            field.text = string
            field.resignFirstResponder()
            field.nextTextFiled?.becomeFirstResponder()
            return true
        }
        return true
    }
}
