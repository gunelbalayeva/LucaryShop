//
//  SplashView.swift
//  LucaryShop
//
//  Created by User on 08.06.25.
//

import SnapKit
import UIKit

final class SplashView: UIView {
    
    let shadowView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 150
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 8)
        view.layer.shadowRadius = 15
        view.layer.masksToBounds = false
        return view
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 100
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let animatedLabel: UILabel = {
        let label = UILabel()
        label.text = "Lucary"
        label.font = UIFont(name: "MeaCulpa-Regular", size: 60)
        label.textAlignment = .center
        label.textColor = UIColor(named: "logoColor")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [logoImageView, animatedLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        addSubview(shadowView)
        shadowView.addSubview(stackView)
        
        shadowView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(200)
        }
    }
}
