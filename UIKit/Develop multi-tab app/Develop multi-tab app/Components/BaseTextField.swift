//
//  BaseTextField.swift
//  Develop multi-tab app
//
//  Created by Temur Chitashvili on 16.06.25.
//

import UIKit

final class BaseTextField: UITextField {
    private var textPadding = UIEdgeInsets(
        top: 12,
        left: 16,
        bottom: 12,
        right: 16
    )
    
    override init(
        frame: CGRect
    ) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(
        coder: NSCoder
    ) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(
        placeholder: String,
        font: UIFont = .systemFont(
            ofSize: 18,
            weight: .regular
        ),
        textColor: UIColor = .black,
        backgroundColor: UIColor = .white,
        cornerRadius: CGFloat = 16,
        borderWidth: CGFloat = 0,
        borderColor: UIColor? = nil,
        placeholderColor: UIColor = .lightGray,
        padding: UIEdgeInsets = UIEdgeInsets(
            top: 12,
            left: 16,
            bottom: 12,
            right: 16
        )
    ) {
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor?.cgColor
        self.layer.masksToBounds = true
        self.textPadding = padding
        
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: placeholderColor,
                .font: font
            ]
        )
    }
    
    // Override text positioning methods
    override func textRect(
        forBounds bounds: CGRect
    ) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override func editingRect(
        forBounds bounds: CGRect
    ) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override func placeholderRect(
        forBounds bounds: CGRect
    ) -> CGRect {
        return bounds.inset(by: textPadding)
    }
}
