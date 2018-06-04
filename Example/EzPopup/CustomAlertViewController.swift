//
//  CustomAlertViewController.swift
//  EzPopup_Example
//
//  Created by Huy Nguyen on 6/4/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class CustomAlertViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var titleString: String?
    var messageString: String?
    
    static func instantiate() -> CustomAlertViewController? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(CustomAlertViewController.self)") as? CustomAlertViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = titleString
        messageLabel.text = messageString
    }

    // MARK: Actions
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
