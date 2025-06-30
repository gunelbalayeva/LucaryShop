//
//  AboutViewController.swift
//  LucaryShop
//
//  Created by User on 29.06.25.
//

import Foundation
import UIKit
final class AboutViewController: UIViewController {
    private let viewModel: AboutViewModel
    private let aboutView = AboutView()

    init(viewModel: AboutViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = aboutView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        configure()
    }

    private func configure() {
        aboutView.setText(viewModel.aboutText)
        if let url = viewModel.videoURL {
            aboutView.setVideo(url: url)
        }
        aboutView.setImage(named: viewModel.imageName)
        aboutView.setMap(coordinate: viewModel.location)
        aboutView.setContactInfo(text: viewModel.contactInfoText)
    }
    
    private func setupNavigationBar() {
        let config = UIImage.SymbolConfiguration(weight: .heavy)
        let image = UIImage(systemName: "chevron.backward", withConfiguration: config)
        let backButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .darkGray
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
