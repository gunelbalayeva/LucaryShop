//
//  PermissionsOnboardingView.swift
//  LucaryShop
//
//  Created by User on 10.06.25.
//

import UIKit

final class PermissionsOnboardingView: UIView {
    
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
        containerView.addSubviews(views: imageContainerView, titleLabel, startNowButton)
        imageContainerView.addSubview(imageView)
        self.addSubviewSnp(containerView, insets: .zero)
        imageContainerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(80)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        imageContainerView.setSize(width: 396, height: 480)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageContainerView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        startNowButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
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
