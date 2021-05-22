//
//  ProgressShapeLayer.swift
//  Feedback App
//
//  Created by Edward Guilllermo on 5/21/21.
//

import UIKit

class ProgressShapeLayer: CAShapeLayer {

    public init(strokeColor: UIColor, lineWidth: CGFloat) {
        super.init()
        self.strokeColor = strokeColor.cgColor
        self.lineWidth = lineWidth
        self.fillColor = UIColor.clear.cgColor
        self.lineCap = .round
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
