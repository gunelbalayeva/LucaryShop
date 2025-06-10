//
//  PermissionsOnboardingView.swift
//  LucaryShop
//
//  Created by User on 10.06.25.
//

import UIKit

final class PermissionsOnboardingView: UIView {
    
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
    
    private let startNowButton: CustomButton = {
        let button = CustomButton(style: .filled, height: 50, width: 200)
        button.setTitle("Start Now", for: .normal)
        return button
    }()
    
    
    var onButtonTapped: (() -> Void)?
    init(viewModel: PermissionsOnboardingViewModel, onButtonTapped: (() -> Void)? = nil) {
        self.onButtonTapped = onButtonTapped
        super.init(frame: .zero)
        
        setupLayout()
        setupActions()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupLayout() {
        self.addSubviews(views: containerView)
        containerView.addSubviews(views: imageView, titleLabel, startNowButton)
        self.addSubviewSnp(containerView, insets: .zero)
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        imageView.setSize(width: 396, height: 488)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        startNowButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(100)
            $0.centerX.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview().offset(-20)
        }
        startNowButton.setSize(width: 200, height: 48)
    }
    
    private func setupActions() {
        startNowButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    private func buttonTapped() {
        onButtonTapped?()
    }
    
    
    func setLoading(_ isLoading: Bool) {
        startNowButton.showLoading(isLoading)
    }
    
    func configure(viewModel: PermissionsOnboardingViewModel) {
        imageView.image = viewModel.image
        titleLabel.text = viewModel.titleText
    }
    
}
