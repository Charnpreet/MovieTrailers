//
//  RatingCircle.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 10/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class RatingCircle: UIView {
    
    fileprivate var progresslayer = CAShapeLayer()
    fileprivate var trackLayer = CAShapeLayer()
    fileprivate var pulasatingLayer: CAShapeLayer!
    var progress: CAShapeLayer {
        get {
            return self.progresslayer
        }
    }
    
    var progressColor = UIColor.white {
        didSet{
            progresslayer.strokeColor = progressColor.cgColor
        }
    }
    var trackColor = UIColor.lightGray {
        didSet{
            trackLayer.strokeColor = trackColor.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createCircularPath()
    }
    
    func setupLayers(clayer: CAShapeLayer, strokeColor: CGColor,fillColor: CGColor){
        let xLoc = frame.size.width/2
        let yLoc = frame.size.height/2
        let circlePath = UIBezierPath(arcCenter: CGPoint(x:xLoc , y: yLoc), radius: 25, startAngle: -CGFloat.pi/2, endAngle: CGFloat(1.5 * .pi), clockwise: true)
        clayer.path = circlePath.cgPath
        clayer.strokeColor = strokeColor
        clayer.fillColor = fillColor//
        clayer.lineWidth = 4.0
        clayer.lineCap  = .round
        layer.addSublayer(clayer)

    }
    private func createCircularPath() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = self.frame.size.width/2
        // creating pulsating layer
        pulasatingLayer = CAShapeLayer()
        //
        setupLayers(clayer: pulasatingLayer, strokeColor: UIColor.yellow.cgColor, fillColor: UIColor.clear.cgColor)
        
        setupLayers(clayer: trackLayer, strokeColor: trackColor.cgColor, fillColor: UIColor.clear.cgColor)
        
        setupLayers(clayer: progresslayer, strokeColor: progressColor.cgColor,fillColor: UIColor.clear.cgColor)
        
        progresslayer.strokeEnd = 0.0
    }
    public func LoadingBarAnimation(toValue: Float){
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = toValue //0.8
        basicAnimation.duration = 1
        basicAnimation.fillMode = .both
        basicAnimation.isRemovedOnCompletion = false
        progresslayer.add(basicAnimation, forKey: "basic")
        
    }
    //
//     public func pulsatingAnimation(){
//         let animation = CABasicAnimation(keyPath: "tranform.scale")
//         animation.toValue = 1.5
//         animation.duration = 1.8
//         animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
//         animation.autoreverses = true
//         animation.repeatCount = Float.infinity
//         pulasatingLayer.add(animation, forKey: "pulsing")
//     }
}
