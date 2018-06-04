//
//  ViewController.swift
//  EzPopup
//
//  Created by huynguyencong on 06/04/2018.
//  Copyright (c) 2018 huynguyencong. All rights reserved.
//

import UIKit
import EzPopup

class ViewController: UIViewController {
    
    let customAlertVC = CustomAlertViewController.instantiate()

    @IBAction func testButtonTapped(_ sender: Any) {
        guard let customAlertVC = customAlertVC else { return }
        
        customAlertVC.titleString = "Congratulation"
        customAlertVC.messageString = "You just showed a custom alert view controller."
        
        let popupVC = PopupViewController(contentController: customAlertVC, position: .right(60), popupWidth: 300)
        present(popupVC, animated: true, completion: nil)
    }
    
}

