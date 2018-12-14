//
//  MyViewController.swift
//  PanGesture
//
//  Copyright © 2018 ali ziwa. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame = CGRect(x: 10, y: 50, width: 300, height: 400)
        view.backgroundColor = .white
        view.layer.addSublayer(samplerView())
    }
    
    func samplerView()  -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 3
        layer.lineDashPattern = [1, 5]
        layer.lineCap = CAShapeLayerLineCap.round
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 10, y: 140), CGPoint(x: 100, y: 140)])
        path.addArc(center: CGPoint(x: 120, y: 140), radius: 20, startAngle: CGFloat(0.0), endAngle: CGFloat(Double.pi), clockwise: true)
        path.addLines(between: [CGPoint(x: 140, y: 140), CGPoint(x: 300, y: 140)])
        layer.path = path
        
        let lineAnim = CABasicAnimation(keyPath: "lineDashPhase")
        lineAnim.fromValue = 0
        lineAnim.toValue = layer.lineDashPattern?.reduce(0, { $0 + $1.intValue})
        lineAnim.duration = 0.5
        lineAnim.repeatCount = Float.greatestFiniteMagnitude
        layer.add(lineAnim, forKey: nil)
        return layer
    }
}
