//
//  StrokeColorAnimation.swift
//  Feedback App
//
//  Created by Edward Guilllermo on 5/21/21.
//

import UIKit

class StrokeColorAnimation: CAKeyframeAnimation {

    override init() {
        super.init()
    }
        
    init(colors: [CGColor], duration: Double) {
        super.init()
        self.keyPath = "strokeColor"
        self.values = colors
        self.duration = duration
        self.repeatCount = .greatestFiniteMagnitude
        self.timingFunction = .init(name: .easeInEaseOut)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
