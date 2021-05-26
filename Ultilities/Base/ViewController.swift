//
//  ViewController.swift
//  BaseProject
//
//  Created by linhld on 26/05/2021.
//

import UIKit
import RxSwift
import RxCocoa
import NVActivityIndicatorView

class ViewController: UIViewController, Navigatable {

    var navigator: Navigator!
    
    let isLoading = BehaviorRelay(value: false)
    
    var disposeBag = DisposeBag()
    
    var navigationTitle = "" {
        didSet {
            navigationItem.title = navigationTitle
        }
    }
    
    lazy var backBarButton: UIBarButtonItem = {
        let view = UIBarButtonItem()
        view.title = ""
        view.image = UIImage(named: "ic_navigation_back")
        view.tintColor = UIColor(hexString: "#343638")
        view.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        view.target = self
        view.action = #selector(didPressBackButton)
        return view
    }()
    
    //private lazy var panGR: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(leftSwipeDismiss(gestureRecognizer:)))
    
    public var enableScreenPanGesture: Bool = true {
        didSet {
            /*if(enableScreenPanGesture) {
                self.view.addGestureRecognizer(self.panGR)
                return
            }
            if self.view.gestureRecognizers?.contains(panGR) ?? false {
                self.view.removeGestureRecognizer(panGR)
            }*/
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0);
        self.extendedLayoutIncludesOpaqueBars = false;
        makeUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableScreenPanGesture = navigationController?.viewControllers.count ?? 0 > 1 && navigationController?.viewControllers.last == self
        if (self.navigationController?.viewControllers.count ?? 0) > 1 {
            self.navigationItem.leftBarButtonItem = backBarButton
        }
    }
    
    deinit {
        #if DEBUG
        print("\(type(of: self)): Deinited")
        #endif
    }

    @objc func didPressBackButton() {
        navigator.pop(sender: self)
    }
    
    @objc func leftSwipeDismiss(gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: nil)
        let progress = translation.x / 2 / view.bounds.width
        let gestureView = gestureRecognizer.location(in: self.view)
        
        switch gestureRecognizer.state {
        case .began:
            if gestureView.x <= 30 {
//                hero.dismissViewController()
            }
            print("begin")
            break
        case .changed:
            let translation = gestureRecognizer.translation(in: nil)
//            let progress = translation.x / 2 / view.bounds.width
//            Hero.shared.update(progress)
            print("change")
            break
        default:
            if progress + gestureRecognizer.velocity(in: nil).x / view.bounds.width > 0.3 {
                completeSwipeBack()
                return
            }
            print("default")
//            Hero.shared.cancel()
            break
        }
    }
    
    func completeSwipeBack() {
//        Hero.shared.finish()
    }
    
    func updateBackBarButton() {
        enableScreenPanGesture = navigationController?.viewControllers.count ?? 0 > 1 && navigationController?.viewControllers.last == self
        if (self.navigationController?.viewControllers.count ?? 0) > 1 {
            self.navigationItem.leftBarButtonItem = backBarButton
        }
    }
    
    //Setting ui properties or create ui with programmatically code
    func makeUI() {
        isLoading.asDriver()
            .drive(onNext: { [weak self] (isAnimating) in
                guard let `self` = self else { return }
                if isAnimating {
                    self.startAnimating()
                } else {
                    self.stopAnimating()
                }
            }).disposed(by: disposeBag)
    }
    
    //Subscribe view model value follow ui input variables
    func bindViewModel() {
        
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func startAnimating() {
        ProgressHUD.showIn(view)
    }
    
    func stopAnimating() {
        ProgressHUD.removeIn(view)
    }
}
