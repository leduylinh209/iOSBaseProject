//
//  TextField.swift
//  BaseProject
//
//  Created by linhld on 26/05/2021.
//

import UIKit

@IBDesignable
class TextField: UITextField {

    private var _placeHolderColor: UIColor = UIColor(hexString: "#A6ADB4")
    @IBInspectable var placeHolderColor: UIColor {
        get {
            return self._placeHolderColor
        }
        set {
            self._placeHolderColor = newValue
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder ?? "",
                                                            attributes:[NSAttributedString.Key.foregroundColor: newValue])
        }
    }
    
    @IBInspectable var inset: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeUI()
    }
    
    private func makeUI() {
        layer.borderWidth = 2
        layer.borderColor = UIColor(hexString: "#EBEDED").cgColor
        layer.cornerRadius = 6
        layer.masksToBounds = true
        
        placeHolderColor  = _placeHolderColor
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: bounds).inset(by: inset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return super.editingRect(forBounds: bounds).inset(by: inset)
    }
}
