//
//  SuccessUserRegisterPopup.swift
//  LucaryShop
//
//  Created by User on 02.07.25.
//

import Foundation
import UIKit
import Lottie
final class SuccessUserRegisterPopup :UIView {
    private let containerView = UIView()
    private let messageLabel = UILabel()
    private let animationView = LottieAnimationView(name: "UpdateSuccess")
    private let userName: String
    
    init(frame: CGRect, userName: String) {
        self.userName = userName
        super.init(frame: frame)
        setupUI()
        playAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        containerView.makeCardStyle()
        addSubview(containerView)
        containerView.centerInSuperview(size: CGSize(width: 300, height: 350))
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        containerView.addSubview(animationView)
        animationView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        messageLabel.text = "Təbriklər,\(userName)! Profil məlumatlarınız yeniləndi."
        messageLabel.setStyle(fontSize: 18, weight: .bold, textColor: UIColor(named: "logoColor") ?? .black, alignment: .center, numberOfLines: 0)
        containerView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(animationView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func playAnimation() {
        animationView.play()
    }
    
    func dismiss(after seconds: Double = 3.0, completion: (() -> Void)? = nil) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 0
            }) { _ in
                self.removeFromSuperview()
                completion?()
            }
        }
    }
}
