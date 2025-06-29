//
//  TermsViewController.swift
//  LucaryShop
//
//  Created by User on 29.06.25.
//

import UIKit
final class TermsViewController: UIViewController {
    private let contentView = TermsView()
    private let viewModel: TermsViewModel

    init(viewModel: TermsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        self.view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        contentView.textView.text = viewModel.termsText
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
