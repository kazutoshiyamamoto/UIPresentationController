//
//  ViewController.swift
//  UIPresentationController
//
//  Created by home on 2019/12/30.
//  Copyright © 2019 Swift-beginners. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tappedButton(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Modal", bundle: nil)
        let modalViewController = storyboard.instantiateViewController(withIdentifier: "Modal") as! ModalViewController
        modalViewController.modalPresentationStyle = .custom
        modalViewController.transitioningDelegate = self
        
        present(modalViewController, animated: true, completion: nil)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        return CustomPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

