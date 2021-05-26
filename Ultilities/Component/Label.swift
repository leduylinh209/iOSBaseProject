//
//  Label.swift
//  BaseProject
//
//  Created by linhld on 26/05/2021.
//

import UIKit

class Label: UILabel {

    var contentInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: contentInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -contentInsets.top,
                left: -contentInsets.left,
                bottom: -contentInsets.bottom,
                right: -contentInsets.right)
        return textRect.inset(by: invertedInsets)
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: contentInsets))
    }

}

extension Label {
    @IBInspectable
    var leftTextInset: CGFloat {
        set { contentInsets.left = newValue }
        get { return contentInsets.left }
    }

    @IBInspectable
    var rightTextInset: CGFloat {
        set { contentInsets.right = newValue }
        get { return contentInsets.right }
    }

    @IBInspectable
    var topTextInset: CGFloat {
        set { contentInsets.top = newValue }
        get { return contentInsets.top }
    }

    @IBInspectable
    var bottomTextInset: CGFloat {
        set { contentInsets.bottom = newValue }
        get { return contentInsets.bottom }
    }
}
