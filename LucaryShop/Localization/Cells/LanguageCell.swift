//
//  LanguageCell.swift
//  LucaryShop
//
//  Created by User on 17.06.25.
//

import UIKit
final class LanguageCell: UITableViewCell{
    private let iconImageView = UIImageView()
    private let languageLabel = UILabel()
    private let stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(language: Language, isSelected: Bool) {
        languageLabel.text = language.title
        iconImageView.image = UIImage(named: language.rawValue)
        accessoryType = isSelected ? .checkmark : .none
    }
    
    private func setupUI() {
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.clipsToBounds = true
        iconImageView.layer.cornerRadius = 15
        languageLabel.font = UIFont.systemFont(ofSize: 16)
        languageLabel.textColor = .label
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(languageLabel)
        contentView.addSubview(stackView)
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
}
