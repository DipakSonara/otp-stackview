//
//  CustomTextField.swift
//  OtpStackView
//
//  Created by Dipak Sonara on 26/10/20.
//

import UIKit

protocol CustomTextFieldDelegate: NSObjectProtocol {
    func textFieldDidDelete(_ textField: CustomTextField)
}

@IBDesignable public class CustomTextField: UITextField {
    var previousTextField: UITextField?
    var nextTextFiled: UITextField?
    // MARK: - Public Properties
    
    weak var deleteDelegate: CustomTextFieldDelegate?
    
    /// Adds padding around text field.
    var edgeInsets: UIEdgeInsets = .zero
    
    /// Padding above and below the text field, between the placeholder label and underline.
    @IBInspectable var textPadding: CGFloat = 0.0
    
    /// The height of the underline when the text field has no text.
    @IBInspectable var underlineHeight: CGFloat = 0.0
    
    /// The height of the underline when the text field has text.
    @IBInspectable var underlineEditingHeight: CGFloat = 0.0
    
    /// The color of the underline when the text field has no text.
    @IBInspectable var underlineColor: UIColor?
    
    /// The color of the underline when the text field has text.
    @IBInspectable var underlineEditingColor: UIColor?
    
    // MARK: - Private Properties
    
    private var underlineLayer = CALayer()
    
    // MARK: Public interface
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
    }
    
    public func configure() {
        self.backgroundColor = UIColor.white
        self.font = UIFont.systemFont(ofSize: 16)
        self.textColor = UIColor.darkGray
    }
    
    // MARK: Overrides
    override public func layoutSubviews() {
        super.layoutSubviews()
        layoutUnderlineLayer()
    }
    
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: bounds.inset(by: edgeInsets))
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return super.editingRect(forBounds: bounds.inset(by: edgeInsets))
    }
    
    // MARK: - Setup
    
    func setupViews() {
        textAlignment = .center
        textPadding = 8.0
        underlineEditingColor = .clear
        underlineColor = .clear
        underlineHeight = 1.0
        underlineEditingHeight = 1.3
        edgeInsets = .init(top: 0, left: 0, bottom: underlineHeight, right: 0)
        setupUnderline()
    }
    
    fileprivate func setupUnderline() {
        underlineLayer = CALayer()
        layoutUnderlineLayer()
        layer.addSublayer(underlineLayer)
    }
    
    
    
    fileprivate func layoutUnderlineLayer() {
        updateUnderlineColor()
        updateUnderlineFrame()
    }
    
    // MARK: - Underline
    
    func updateUnderlineColor() {
        let color: UIColor? = (hasText || isFirstResponder) ? underlineEditingColor : underlineColor
        underlineLayer.backgroundColor = color?.cgColor
    }
    
    func updateUnderlineFrame() {
        let height = (hasText || isFirstResponder) ? underlineEditingHeight : underlineHeight
        let yPos: CGFloat = bounds.height + textPadding - height
        underlineLayer.frame = CGRect(x: 0, y: yPos, width: bounds.width, height: height)
    }
    
    public override func deleteBackward() {
        super.deleteBackward()
        text = ""
        previousTextField?.becomeFirstResponder()
        deleteDelegate?.textFieldDidDelete(self)
    }
    
}



