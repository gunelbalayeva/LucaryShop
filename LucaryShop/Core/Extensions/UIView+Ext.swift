//
//  UIView+Ext.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit
import SnapKit

extension UIView {
    
    // MARK: - Add Subview with Insets to Superview
    func addSubviewSnp(_ view: UIView, insets: UIEdgeInsets) {
        self.addSubview(view)
        view.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(insets.top)
            make.bottom.equalToSuperview().inset(insets.bottom)
            make.leading.equalToSuperview().inset(insets.left)
            make.trailing.equalToSuperview().inset(insets.right)
        }
    }
    
    
    // MARK: - Add Subview with Insets to a Target Constraint
    func addSubviewSnp(_ view: UIView, to target: ConstraintRelatableTarget, insets: UIEdgeInsets) {
        self.addSubview(view)
        view.snp.makeConstraints { make in
            make.top.equalTo(target).inset(insets.top)
            make.bottom.equalTo(target).inset(insets.bottom)
            make.leading.equalTo(target).inset(insets.left)
            make.trailing.equalTo(target).inset(insets.right)
        }
    }
    
    
    // MARK: - Add Multiple Subviews at Once
    func addSubviews(views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
    
    
    // MARK: - Center View in Superview
    func centerInSuperview() {
        guard let superview = self.superview else { return }
        self.snp.makeConstraints { make in
            make.center.equalTo(superview)
        }
    }
    
    
    // MARK: - Center View in Superview with Size
    func centerInSuperview(size: CGSize) {
        guard let superview = self.superview else { return }
        self.snp.makeConstraints { make in
            make.center.equalTo(superview)
            make.size.equalTo(size)
        }
    }
    
    
    // MARK: - Set Size Constraints
    func setSize(width: CGFloat, height: CGFloat) {
        self.snp.makeConstraints { make in
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    
    // MARK: - Set Width Constraint
    func setWidth(_ width: CGFloat) {
        self.snp.makeConstraints { make in
            make.width.equalTo(width)
        }
    }
    
    
    // MARK: - Set Height Constraint
    func setHeight(_ height: CGFloat) {
        self.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
    }
}
