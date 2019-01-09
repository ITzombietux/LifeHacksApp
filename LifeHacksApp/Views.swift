//
//  RoundImageView.swift
//  LifeHacksApp
//
//  Created by zombietux on 09/01/2019.
//  Copyright © 2019 zombietux. All rights reserved.
//

import UIKit

extension CGRect {
    func shifted(by x: CGFloat) -> CGRect {
        var newRect = self
        newRect.origin.x += x
        return newRect
    }
}

@IBDesignable class RoundImageView: UIImageView {}

@IBDesignable
class RoundTextField: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.shifted(by: 12.0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.shifted(by: 12.0)
    }
}

@IBDesignable class RoundTextView: UITextView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set { layer.borderColor = newValue?.cgColor }
    }
}
