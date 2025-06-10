//
//  BaseButton.swift
//  Calculator App
//
//  Created by Temur Chitashvili on 10.06.25.
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
        titleColor: UIColor = .white,
        titleFont: UIFont = .systemFont(ofSize: 24, weight: .medium),
        cornerRadius: CGFloat = 16,
        textAlignment: NSTextAlignment = .center,
        borderWidth: CGFloat = 0,
        borderColor: UIColor? = nil
    ) {
        self.titleLabel?.textAlignment = textAlignment
        self.titleLabel?.font = titleFont
        self.setTitleColor(titleColor, for: .normal)
        self.setTitle(title, for: .normal)
        self.backgroundColor = color
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addAction(UIAction(handler: { [weak self]  _ in
            self?.backgroundColor = color.withAlphaComponent(0.5)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
                self?.backgroundColor = color
            }
        }),
                       for: .touchUpInside)
        self.layer.borderColor = borderColor?.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = true
    }
}
