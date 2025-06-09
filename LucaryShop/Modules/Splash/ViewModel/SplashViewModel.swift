//
//  SplashViewModel.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
import UIKit

final class SplashViewModel {
    
    func addShimmerEffect(to logoImageView: UIImageView) {
        logoImageView.layer.sublayers?.forEach { layer in
            if layer is CAGradientLayer {
                layer.removeFromSuperlayer()
            }
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor(red: 255/255, green: 215/255, blue: 0/255, alpha: 0.5).cgColor,
            UIColor.clear.cgColor
        ]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = logoImageView.bounds
        gradientLayer.cornerRadius = logoImageView.layer.cornerRadius
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(ovalIn: logoImageView.bounds).cgPath
        gradientLayer.mask = maskLayer
        logoImageView.layer.addSublayer(gradientLayer)
        
        let shimmerAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        shimmerAnimation.fromValue = -logoImageView.frame.width
        shimmerAnimation.toValue = logoImageView.frame.width
        shimmerAnimation.duration = 2.5
        shimmerAnimation.repeatCount = .infinity
        gradientLayer.add(shimmerAnimation, forKey: "shimmer")
        
        var transform = CATransform3DIdentity
        transform.m34 = -1.0 / 500.0
        logoImageView.layer.transform = transform
        
        let waveAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.y")
        waveAnimation.values = [0.0, 0.12, -0.12, 0.12, 0.0]
        waveAnimation.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
        waveAnimation.duration = 2.5
        waveAnimation.repeatCount = .infinity
        waveAnimation.isAdditive = true
        logoImageView.layer.add(waveAnimation, forKey: "flagWave")
    }
    
    func startWaveAnimation(on shadowView: UIView) {
        let waveAnimation = CAKeyframeAnimation(keyPath: "transform.rotation")
        waveAnimation.values = [0, 0.05, -0.05, 0]
        waveAnimation.keyTimes = [0, 0.25, 0.75, 1]
        waveAnimation.duration = 1.5
        waveAnimation.repeatCount = .infinity
        shadowView.layer.add(waveAnimation, forKey: "wave")
    }
    
    func startLabelAnimation(for label: UILabel) {
        guard let text = label.text else { return }
        label.text = ""
        var charIndex = 0.0
        for letter in text {
            let delay = charIndex * 0.15
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                label.text?.append(letter)
            }
            charIndex += 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + charIndex) {
            self.startLabelAnimation(for: label)
        }
    }
}
