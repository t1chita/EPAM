//
//  BaseButton.swift
//  Develop multi-tab app
//
//  Created by Temur Chitashvili on 16.06.25.
//

import UIKit

final class BaseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(
        withColor color: UIColor,
        title: String,
        isEnabled: Bool = true,
        titleColor: UIColor = .white,
        titleFont: UIFont = .systemFont(ofSize: 24, weight: .medium),
        cornerRadius: CGFloat = 12,
        textAlignment: NSTextAlignment = .center,
        borderWidth: CGFloat = 0,
        borderColor: UIColor? = nil,
        contentPadding: UIEdgeInsets = UIEdgeInsets(
            top: 12,
            left: 24,
            bottom: 12,
            right: 24
        )
    ) {
        self.titleLabel?.textAlignment = textAlignment
        self.titleLabel?.font = titleFont
        self.setTitleColor(titleColor, for: .normal)
        self.setTitle(title, for: .normal)
        self.backgroundColor = color
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentEdgeInsets = contentPadding
        self.isEnabled = isEnabled
        
        self.addAction(UIAction(handler: { [weak self]  _ in
            self?.alpha = 0.5

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
                self?.alpha = 1
            }
        }),
                       for: .touchUpInside)
        
        self.layer.borderColor = borderColor?.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = true
        
        if !isEnabled {
            self.alpha = 0.5
        }
    }
}
