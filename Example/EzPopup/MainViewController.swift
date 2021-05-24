//
//  MainViewController.swift
//  EzPopup
//
//  Created by huynguyencong on 06/04/2018.
//  Copyright (c) 2018 huynguyencong. All rights reserved.
//

import UIKit
import EzPopup

class MainViewController: UIViewController {
    
    let customAlertVC = CustomAlertViewController.instantiate()
    let pickerVC = NumberPickerViewController.instantiate()
    
    @IBOutlet weak var bottomButton: UIButton!
    
    // MARK: - Actions

    @IBAction func showAtCenterButtonTapped(_ sender: Any) {
        guard let customAlertVC = customAlertVC else { return }
        
        customAlertVC.titleString = "Congratulation"
        customAlertVC.messageString = "You just showed a custom alert view controller."
        
        let popupVC = PopupViewController(contentController: customAlertVC, popupWidth: 300)
        popupVC.cornerRadius = 5
        popupVC.delegate = self
        present(popupVC, animated: true, completion: nil)
    }
    
    @IBAction func showTopRightButtonTapped(_ sender: Any) {
        guard let pickerVC = pickerVC else { return }
        
        pickerVC.delegate = self
        
        let popupVC = PopupViewController(contentController: pickerVC, position: .topRight(CGPoint(x: 16, y: 40)), popupWidth: 100, popupHeight: 200)
        popupVC.canTapOutsideToDismiss = false
        popupVC.cornerRadius = 5
        present(popupVC, animated: true, completion: nil)
    }
    
    @IBAction func showFullCustomPopupButtonTapped(_ sender: Any) {
        guard let pickerVC = pickerVC else { return }
        
        pickerVC.delegate = self
        
        let popupVC = PopupViewController(contentController: pickerVC, position: .bottom(20), popupWidth: 200, popupHeight: 300)
        popupVC.backgroundAlpha = 0.3
        popupVC.backgroundColor = .black
        popupVC.canTapOutsideToDismiss = true
        popupVC.cornerRadius = 10
        popupVC.shadowEnabled = true
        popupVC.delegate = self
        present(popupVC, animated: true, completion: nil)
    }
    
    @IBAction func showPopUpBelowButtonTapped(_ sender: Any) {
        guard let pickerVC = pickerVC else { return }
        
        pickerVC.delegate = self
        
        let popupVC = PopupViewController(
            contentController: pickerVC,
            position: .offsetFromView(CGPoint(x: 0, y: bottomButton.frame.height + 3), bottomButton),
            popupWidth: 100,
            popupHeight: 200
        )
        
        popupVC.canTapOutsideToDismiss = false
        popupVC.cornerRadius = 5
        present(popupVC, animated: true, completion: nil)
    }
}

extension MainViewController: NumberPickerViewControllerDelegate {
    func numberPickerViewController(sender: NumberPickerViewController, didSelectNumber number: Int) {
        dismiss(animated: true) {
            let alertController = UIAlertController(title: "Good luck", message: "Good luck with your number \(number)", preferredStyle: .alert)
            
            let closeButton = UIAlertAction(title: "Close", style: .cancel)
            alertController.addAction(closeButton)
            
            self.present(alertController, animated: true)
        }
    }
}

extension MainViewController: PopupViewControllerDelegate {
    func popupViewControllerDidDismissByTapGesture(_ sender: PopupViewController) {
        print("log - popupViewControllerDidDismissByTapGesture")
    }
}
