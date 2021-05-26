//
//  ProgressHUD.swift
//  BaseProject
//
//  Created by linhld on 26/05/2021.
//

import UIKit
import NVActivityIndicatorView

class ProgressHUD: UIView {

    lazy var hudView = NVActivityIndicatorView(frame: self.bounds)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeUI()
    }
    
    private func makeUI() {
        self.backgroundColor = UIColor(white: 0, alpha: 0.3)
        addSubview(hudView)
        NSLayoutConstraint.activate([
            hudView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            hudView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            hudView.widthAnchor.constraint(equalToConstant: 44),
            hudView.heightAnchor.constraint(equalToConstant: 44)
        ])
        hudView.startAnimating()
    }

    static func showIn(_ view: UIView) {
        removeIn(view)
        let progressView = ProgressHUD(frame: view.bounds)
        view.addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.topAnchor),
            progressView.leftAnchor.constraint(equalTo: view.leftAnchor),
            progressView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            progressView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    static func removeIn(_ view: UIView) {
        view.subviews
        .filter{ $0 is ProgressHUD }
        .forEach { $0.removeFromSuperview() }
    }
}
