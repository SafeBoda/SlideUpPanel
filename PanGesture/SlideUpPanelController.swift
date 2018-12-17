//
//  HomeViewController.swift
//  PanGesture
//
//  Created by ali ziwa on 13/12/2018.
//  Copyright © 2018 ali ziwa. All rights reserved.
//

import UIKit

class SlideUpPanelController: UIViewController {

    @IBOutlet weak var defButton: UIButton!
    @IBOutlet weak var abcButton: UIButton!
    @IBOutlet weak var panelView: UIView!
    
    private var parentController: UIViewController!
    private var contentController: UIViewController!
    private var animator: UIViewPropertyAnimator!
    
    init(parent: UIViewController, content: UIViewController) {
        parentController = parent
        contentController = content
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViewController(contentController)
        addViewController(parentController, subMerge: true)
        view.bringSubviewToFront(panelView)
        registerPanGesture()
        registerAnimator()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animator.addAnimations {[unowned self] in
            self.panelView.frame.origin.y = self.minimumY
        }
        animator.startAnimation()
    }
    
    private func addViewController(_ controller: UIViewController, subMerge: Bool = false) {
        addChild(controller)
        controller.view.frame = subMerge ? view.frame: CGRect(x: 0, y: 20, width: panelView.frame.width, height: panelView.frame.height)
        subMerge ? view.addSubview(controller.view) : panelView.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
    
    private func registerAnimator() {
        animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut)
    }
    
    private func registerPanGesture() {
        let panGes = UIPanGestureRecognizer(target: self, action: #selector(panGesture(recogniser:)))
        panelView.addGestureRecognizer(panGes)
    }
    
    @objc func panGesture(recogniser: UIPanGestureRecognizer) {
        let yTranslation = recogniser.translation(in: self.view).y
        let originalY = self.panelView.frame.origin.y
        let newTransition = originalY + yTranslation
        
        if recogniser.state == .changed {
            animator.addAnimations { [weak self] in
                self?.panelView.frame.origin.y = newTransition
                self?.addCurves(newTransition > 0)
            }
            
            animator.startAnimation()
            
        } else if recogniser.state == .ended {
            animator.addAnimations { [unowned self] in
                let transition = self.moveTo(nextY: newTransition)
                switch transition {
                case .collapsed:
                    self.panelView.frame.origin.y = self.minimumY
                    self.addCurves(false)
                case .expanded:
                    self.panelView.frame.origin.y = self.maximumY
                    self.addCurves(true)
                }
            }
            animator.startAnimation()
        }
        
        recogniser.setTranslation(.zero, in: self.view)
    }
    
    private func addCurves(_ bool: Bool) {
        if #available(iOS 11.0, *) {
            panelView.layer.masksToBounds = bool
            panelView.layer.cornerRadius = bool ? 5.0 : 0.0
            panelView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
    
    private func moveTo(nextY: CGFloat) -> PanelStates {
        let collapsedY = minimumY
        let expandedY = maximumY
        return (nextY - expandedY ) < (collapsedY - nextY) ? .expanded : .collapsed
    }
}

extension SlideUpPanelController: HeightsDelegate {
    var maximumY: CGFloat {
        return 40.0
    }
    
    var minimumY: CGFloat {
        return self.view.frame.height / 2
    }
}

protocol HeightsDelegate: AnyObject {
    var maximumY: CGFloat { get }
    var minimumY: CGFloat { get }
}

enum PanelStates {
    case collapsed
    case expanded
}
