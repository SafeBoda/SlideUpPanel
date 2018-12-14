//
//  PanelGrabView.swift
//  PanGesture
//
//  Created by ali ziwa on 14/12/2018.
//  Copyright © 2018 ali ziwa. All rights reserved.
//

import UIKit

class PanelGrabView: UIView {
    @IBOutlet var grabView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        grabView = Bundle.main.loadNibNamed("PanelGrabView", owner: self, options: nil)?.first as? PanelGrabView
        grabView.frame = bounds
        grabView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(grabView)
    }
}
