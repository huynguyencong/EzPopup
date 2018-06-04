//
//  PopupViewController.swift
//  EzPopup
//
//  Created by Huy Nguyen on 6/4/18.
//

import UIKit

protocol PopupViewControllerDelegate: class {
    func popupViewControllerDidDismiss(sender: PopupViewController)
}

// optional func
extension PopupViewControllerDelegate {
    func popupViewControllerDidDismiss(sender: PopupViewController) {}
}

public class PopupViewController: UIViewController {
    
    public var popupWidth: CGFloat?
    public var popupHeight: CGFloat?
    public var backgroundAlpha: CGFloat = 0.5
    public var backgroundColor = UIColor.black
    public var canTapOutsideToDismiss = true
    
    public var contentController: UIViewController?
    public var contentView: UIView?
    
    weak var delegate: PopupViewControllerDelegate?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init(contentController: UIViewController, popupWidth: CGFloat? = nil, popupHeight: CGFloat? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.contentController = contentController
        self.contentView = contentController.view
        self.popupWidth = popupWidth
        self.popupHeight = popupHeight
        
        commonInit()
    }
    
    public init(contentView: UIView, popupWidth: CGFloat? = nil, popupHeight: CGFloat? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.contentView = contentView
        self.popupWidth = popupWidth
        self.popupHeight = popupHeight
        
        commonInit()
    }
    
    private func commonInit() {
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
        view.backgroundColor = backgroundColor.withAlphaComponent(backgroundAlpha)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        contentView?.translatesAutoresizingMaskIntoConstraints = false

        setupViews()
        addDismissGesture()
    }

    private func addDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissTapGesture(gesture:)))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupViews() {
        guard let contentView = contentView else {
            print("NOTE: Please set contentView")
            return
        }
        
        if let contentController = contentController {
            addChildViewController(contentController)
        }
        
        view.addSubview(contentView)
        
        addSizeConstraints()
        addPositionConstraints()
    }
    
    private func addSizeConstraints() {
        guard let contentView = contentView else { return }
        
        if let popupWidth = popupWidth {
            let widthConstraint = NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: popupWidth)
            NSLayoutConstraint.activate([widthConstraint])
        }
        
        if let popupHeight = popupHeight {
            let heightConstraint = NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: popupHeight)
            NSLayoutConstraint.activate([heightConstraint])
        }
    }
    
    private func addPositionConstraints() {
        guard let contentView = contentView else { return }
        let centerXConstraint = NSLayoutConstraint(item: contentView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: contentView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([centerXConstraint, centerYConstraint])
    }

    // MARK: - Actions
    
    @objc func dismissTapGesture(gesture: UIGestureRecognizer) {
        dismiss(animated: true) {
            self.delegate?.popupViewControllerDidDismiss(sender: self)
        }
    }
}

extension PopupViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let touchView = touch.view, let contentView = contentView, canTapOutsideToDismiss else {
            return false
        }
        
        return !touchView.isDescendant(of: contentView)
    }
}
