//
//  TermsView.swift
//  LucaryShop
//
//  Created by User on 29.06.25.
//

import UIKit
final class TermsView: UIView {
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.textColor = .baseButton
        tv.isEditable = false
        tv.isScrollEnabled = true
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        backgroundColor = .systemBackground
        addSubview(textView)
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
}
