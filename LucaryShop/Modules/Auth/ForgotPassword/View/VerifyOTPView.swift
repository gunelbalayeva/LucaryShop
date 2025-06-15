//
//  VerifyOTPView.swift
//  LucaryShop
//
//  Created by User on 12.06.25.
//

import UIKit
import Lottie

final class VerifyOTPView:UIView{
    var verifyOTPCodeTapped: (() -> Void)?

    private let animationView: LottieAnimationView = {
        let animation = LottieAnimationView(name: "VerifyOTP")
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .loop
        animation.play()
        return animation
    }()
    
    private let headLabel = UILabel().withStyle(text: "Enter OTP Code", size: 24)
    let oneTextField = CustomTextField().with(placeholder: "")
    let twoTextField = CustomTextField().with(placeholder: "")
    let threeTextField = CustomTextField().with(placeholder: "")
    let fourTextField = CustomTextField().with(placeholder: "")
    let fiveTextField = CustomTextField().with(placeholder: "")
    let sixTextField :CustomTextField = {
        let textField = CustomTextField().with(placeholder: "")
        textField.layer.cornerRadius = 12
        textField.isSecureTextEntry = true
        textField.textContentType = .none
        textField.tintColor = .black
        textField.setHeight(52)
        return textField
    }()
    
    let submitButton: CustomButton = {
        let button = CustomButton(style: .filled)
        button.setTitle("Submit", for: .normal)
        return button
    }()
    
    private lazy var otpStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            oneTextField, twoTextField, threeTextField,
            fourTextField, fiveTextField, sixTextField
        ])
        stack.configure(axis: .horizontal, alignment: .fill, spacing: 12)
        stack.distribution = .fillEqually
        return stack
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .verifyBg
        addSubviews(views: animationView, headLabel, otpStackView,submitButton)
        [oneTextField, twoTextField, threeTextField, fourTextField, fiveTextField, sixTextField].forEach {
            $0.setHeight(52)
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 20, weight: .medium)
            $0.keyboardType = .numberPad
            $0.textColor = .baseButton
        }
        submitButton.addTarget(self, action: #selector(verifyCodeTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        animationView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(150)
        }
        
        headLabel.snp.makeConstraints { make in
            make.top.equalTo(animationView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        otpStackView.snp.makeConstraints { make in
            make.top.equalTo(headLabel.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(52)
        }
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(otpStackView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc
    func verifyCodeTapped(){
        verifyOTPCodeTapped?()
    }
}
