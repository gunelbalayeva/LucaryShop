//
//  OnboardingPageView.swift
//  LucaryShop
//
//  Created by User on 10.06.25.
//

import UIKit

final class OnboardingPageView: UIView {
    
    private let view = UIView()
    
    private let imageView : UIImageView = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        self.addSubviews(views: view)
        view.addSubviews(views: imageView, titleLabel)
        
        self.addSubviewSnp(view, insets: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(0)
            make.centerX.equalToSuperview()
        }
        imageView.setHeight(488)
        imageView.setWidth(396)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    func configure(viewModel: OnboardingViewModel) {
        imageView.image = viewModel.image
        titleLabel.text = viewModel.titleText
    }
}
