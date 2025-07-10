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
        let imageView = UIImageView(image: UIImage(named: "splashLogo"))
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
        stackView.configure(axis: .vertical, alignment: .center, spacing: 20)
        self.addSubviews(views: shadowView)
        shadowView.addSubviews(views: stackView)
        shadowView.centerInSuperview()
        shadowView.setSize(width: 200, height: 200)
        stackView.centerInSuperview()
        logoImageView.setSize(width: 200, height: 200)
    }
    
}
