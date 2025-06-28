//
//  SecurePaymentViewController.swift
//  LucaryShop
//
//  Created by User on 28.06.25.
//

import UIKit
import Combine
final class SecurePaymentViewController:UIViewController{
    let securePaymentViewModel:SecurePaymentViewModel
    let securePaymentView = SecurePaymentView()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Təhlükəsiz Ödəniş"
        setupNavigationBar()
        bindingViewModel()
    }
    
    override func loadView() {
        self.view = securePaymentView
    }
    
    
    init(securePaymentViewModel: SecurePaymentViewModel) {
        self.securePaymentViewModel = securePaymentViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindingViewModel(){
        securePaymentViewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                isLoading ? self?.showLoading() : self?.hideLoading()
            }
            .store(in: &cancellables)
        securePaymentViewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                if let message = message {
                    self?.showErrorAnimation(message: message)
                }
            }
            .store(in: &cancellables)
        securePaymentView.confirmButtonAction = { [weak self] in
            self?.securePaymentViewModel.confirmOrder { success in
                guard let self = self else { return }
                if success {
                    self.showSuccessfulAnimation(message: "Ödəniş uğurla tamamlandı")
                } else {
                    self.showErrorAnimation(message: "Ödənişdə xəta oldu")
                }
            }
        }
    }
    
    private func showErrorAnimation(message: String) {
        let popup = SecurityErrorPopup(frame: view.bounds, message: message)
        view.addSubview(popup)
        popup.dismiss(after: 3.0)
    }
    
    private func showSuccessfulAnimation(message: String){
        let popup = SecuritySuccessfulPopup(frame: view.bounds, message: message)
        view.addSubview(popup)
        popup.dismiss(after: 3.0)
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
    
    private func showLoading() {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.center = view.center
        spinner.startAnimating()
        spinner.tag = 999
        view.addSubview(spinner)
    }
    
    private func hideLoading() {
        view.viewWithTag(999)?.removeFromSuperview()
    }
}
