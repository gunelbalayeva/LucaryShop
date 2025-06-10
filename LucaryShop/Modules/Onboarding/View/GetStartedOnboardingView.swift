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
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
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
        containerView.addSubviews(views: imageView, titleLabel, buttonsStackView)
        buttonsStackView.addArrangedSubview(signInButton)
        buttonsStackView.addArrangedSubview(signUpButton)

        containerView.snp.makeConstraints { $0.edges.equalToSuperview() }

        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        imageView.setSize(width: 396, height: 488)

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        buttonsStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(170)
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
