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
    let pickerVC = NumberPickerViewController.instantiate()

    @IBAction func showAtCenterButtonTapped(_ sender: Any) {
        guard let customAlertVC = customAlertVC else { return }
        
        customAlertVC.titleString = "Congratulation"
        customAlertVC.messageString = "You just showed a custom alert view controller."
        
        let popupVC = PopupViewController(contentController: customAlertVC, popupWidth: 300)
        popupVC.cornerRadius = 10
        present(popupVC, animated: true, completion: nil)
    }
    
    @IBAction func showTopRightButtonTapped(_ sender: Any) {
        guard let pickerVC = pickerVC else { return }
        
        pickerVC.delegate = self
        
        let popupVC = PopupViewController(contentController: pickerVC, position: .topRight(CGPoint(x: 16, y: 40)), popupWidth: 100, popupHeight: 200)
        popupVC.canTapOutsideToDismiss = false
        present(popupVC, animated: true, completion: nil)
    }
    
}

extension ViewController: NumberPickerViewControllerDelegate {
    func numberPickerViewController(sender: NumberPickerViewController, didSelectNumber number: Int) {
        dismiss(animated: true) {
            let alertController = UIAlertController(title: "Good luck", message: "Good luck with your number \(number)", preferredStyle: .alert)
            
            let closeButton = UIAlertAction(title: "Close", style: .cancel)
            alertController.addAction(closeButton)
            
            self.present(alertController, animated: true)
        }
    }
}
