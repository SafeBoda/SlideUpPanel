//
//  HomeViewController.swift
//  PanGesture
//
//  Created by ali ziwa on 13/12/2018.
//  Copyright © 2018 ali ziwa. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var defButton: UIButton!
    @IBOutlet weak var abcButton: UIButton!
    @IBOutlet weak var panelView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerPanGesture()
    }
    
    private func registerPanGesture() {
        let panGes = UIPanGestureRecognizer(target: self, action: #selector(panGesture(recogniser:)))
        panelView.addGestureRecognizer(panGes)
    }
    
    @objc func panGesture(recogniser: UIPanGestureRecognizer) {
        let yTranslation = recogniser.translation(in: self.view).y
        if recogniser.state == .changed {
            panelView.frame.size.height = panelView.frame.height - yTranslation
            panelView.frame.origin.y = panelView.frame.origin.y + yTranslation
        }
        recogniser.setTranslation(.zero, in: self.view)
    }
}
