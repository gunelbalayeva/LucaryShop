//
//  ProfileView.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import UIKit
import SnapKit

final class ProfileView: UIView {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // Closures
    var onTappedEdited:(() -> Void)?
    var onTappedLanguaceScreenButton:(() -> Void)?
    var onOrdersButton:(() -> Void)?
    var onTappedAboutUs:(() ->Void)?
    var onTappedTermsScreen:(() -> Void)?
    var onTappedLogout:(()->Void)?
    
    private let headImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "profileImage")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let userNameLabel :UILabel = {
        let label =  UILabel().withStyle(text: "Gunel", size: 20)
        label.font =  UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textColor = .gray
        return label
    }()
    
    let surnameLabel = UILabel().withStyle(text: "", size: 14)
    let emailLabel = UILabel().withStyle(text: "gunelbalayeva97@gmail.com", size: 12)
    let editedAccountButton = ProfileView.makeButton(title: "Hesabı redaktə edin")
    let goToLanguaceScreenButton = ProfileView.makeButton(title: "Tətbiq dili")
    let goToOrdersButton = ProfileView.makeButton(title: "Sifarişlərim")
    let goToAboutUsScreenButton = ProfileView.makeButton(title: "Haqqımızda")
    let goToTermsScreenButton = ProfileView.makeButton(title: "Qaydalar və Şərtlər")
    let goToLogoutScreenButton: CustomButton = {
        let button = CustomButton(style: .plain)
        button.setTitle("Çıxış et", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        editedAccountButton.addTarget(self, action: #selector(editedTapped), for: .touchUpInside)
        goToLanguaceScreenButton.addTarget(self, action: #selector(languageTapped), for: .touchUpInside)
        goToOrdersButton.addTarget(self, action: #selector(ordersTapped), for: .touchUpInside)
        goToAboutUsScreenButton.addTarget(self, action: #selector(aboutUsTapped), for: .touchUpInside)
        goToTermsScreenButton.addTarget(self, action: #selector(termsTapped), for: .touchUpInside)
        goToLogoutScreenButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupLayout() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        let headerStack = UIStackView(arrangedSubviews: [
            headImageView,
            userNameLabel,
            surnameLabel,
            emailLabel
        ])
        headerStack.axis = .vertical
        headerStack.alignment = .center
        headerStack.spacing = 8
        
        let buttonsStack = UIStackView(arrangedSubviews: [
            editedAccountButton,
            goToLanguaceScreenButton,
            goToOrdersButton,
            goToAboutUsScreenButton,
            goToTermsScreenButton,
            goToLogoutScreenButton
        ])
        buttonsStack.axis = .vertical
        buttonsStack.spacing = 8
        buttonsStack.alignment = .leading
        let mainStack = UIStackView(arrangedSubviews: [
            headerStack,
            buttonsStack
        ])
        mainStack.axis = .vertical
        mainStack.spacing = 16
        contentView.addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(50)
        }
        headImageView.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
    }
    
    // MARK: - Helpers
    private static func makeButton(title: String) -> CustomButton {
        let button = CustomButton(style: .plain)
        button.setTitle(title, for: .normal)
        button.contentHorizontalAlignment = .leading
        button.setTitleColor(.black, for: .normal)
        return button
    }
    
    
    // objc
    @objc
    func editedTapped(){
        onTappedEdited?()
        print("Salam Edit")
    }
    
    @objc
    func languageTapped(){
        onTappedLanguaceScreenButton?()
        print("Language")
    }
    
    @objc
    func ordersTapped(){
        onOrdersButton?()
        print("Orders")
    }
    
    @objc
    func aboutUsTapped(){
        onTappedAboutUs?()
        print("AboutUs")
    }
    
    @objc
    func termsTapped(){
        onTappedTermsScreen?()
        print("Terms")
    }
    
    @objc
    func logoutTapped(){
        onTappedLogout?()
        print("Logout")
    }
}
