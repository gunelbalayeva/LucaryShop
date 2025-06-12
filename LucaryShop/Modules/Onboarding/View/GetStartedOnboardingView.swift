//
//  GetStartedOnboardingView.swift
//  LucaryShop
//
//  Created by User on 10.06.25.
//

import Foundation
import UIKit


final class GetStartedOnboardingView: UIView {
    
    private let containerView = UIView()
    private let imageContainerView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 7)
        view.layer.shadowRadius = 12
        view.layer.cornerRadius = 30
        view.backgroundColor = .clear
        return view
    }()
    
    private let imageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        return image
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.setStyle(fontName: "Oswald",
                       fontSize: 30, weight: .semibold,
                       textColor: UIColor(named: "onboardingLabelColor") ?? .label,
                       alignment: .center, numberOfLines: 0)
        return label
    }()
    
    private let buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let signInButton: CustomButton = {
        let button = CustomButton(style: .filled, height: 48, width: 180)
        button.setTitle("Daxil ol", for: .normal)
        return button
    }()
    
    private let signUpButton: CustomButton = {
        let button = CustomButton(style: .outlined, height: 48, width: 180)
        button.setTitle("Qeydiyyat", for: .normal)
        return button
    }()
    
    var onSignInTapped: (() -> Void)?
    var onSignUpTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubview(containerView)
        containerView.addSubviews(views: imageContainerView, titleLabel, buttonsStackView)
        imageContainerView.addSubview(imageView)
        buttonsStackView.addArrangedSubview(signInButton)
        buttonsStackView.addArrangedSubview(signUpButton)
        containerView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        imageContainerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(80)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(488)
        }
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageContainerView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        buttonsStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(100)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(326)
            $0.bottom.lessThanOrEqualToSuperview().offset(-40)
        }
        
        signInButton.setHeight(48)
        signUpButton.setHeight(48)
    }
    
    
    private func setupActions() {
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
    }
    
    @objc
    private func signInTapped() {
        onSignInTapped?()
    }
    
    @objc
    private func signUpTapped() {
        onSignUpTapped?()
    }
    
    func configure(viewModel: OnboardingViewModel) {
        imageView.image = viewModel.image
        titleLabel.text = viewModel.titleText
    }
    
    func setLoading(_ isLoading: Bool) {
        signInButton.showLoading(isLoading)
        signUpButton.isEnabled = !isLoading
    }
    
    func configure(viewModel: GetStartedOnboardingViewModel) {
        imageView.image = viewModel.image
        titleLabel.text = viewModel.titleText
    }
}
