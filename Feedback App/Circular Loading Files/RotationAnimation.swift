//
//  RotationAnimation.swift
//  Feedback App
//
//  Created by Edward Guilllermo on 5/21/21.
//

import UIKit

class RotationAnimation: CABasicAnimation {
    
    enum Direction: String {
            case x, y, z
    }
        
    override init() {
        super.init()
    }
        
    public init(
        direction: Direction,
        fromValue: CGFloat,
        toValue: CGFloat,
        duration: Double,
        repeatCount: Float
    ) {
        super.init()
        self.keyPath = "transform.rotation.\(direction.rawValue)"
        self.fromValue = fromValue
        self.toValue = toValue
        self.duration = duration
        self.repeatCount = repeatCount
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
