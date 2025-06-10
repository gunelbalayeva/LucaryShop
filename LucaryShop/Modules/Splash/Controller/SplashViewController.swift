//
//  SplashViewController.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class SplashViewController: UIViewController {
    
    private let splashView = SplashView()
    private let viewModel :SplashViewModel
    private let coordinator: AppCoordinator
    
    
    override func loadView() {
        view = splashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        viewModel.startWaveAnimation(on: splashView.shadowView)
        viewModel.startLabelAnimation(for: splashView.animatedLabel)
        navigateToOnboarding()
    }
    
    init(viewModel: SplashViewModel, coordinator: AppCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewModel.addShimmerEffect(to: splashView.logoImageView)
    }
    
    
    private func navigateToOnboarding() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let builder = OnboardingViewControllerBuilder(coordinator: self.coordinator)
            let onboardingVC = builder.build()
            onboardingVC.modalPresentationStyle = .fullScreen
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.navigationController?.pushViewController(onboardingVC, animated: true)
        }
    }
}
