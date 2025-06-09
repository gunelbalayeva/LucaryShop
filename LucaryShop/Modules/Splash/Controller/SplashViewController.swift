//
//  SplashViewController.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class SplashViewController: UIViewController {
    
    private let splashView = SplashView()
    private let viewModel = SplashViewModel()
    
    override func loadView() {
        view = splashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        
        viewModel.addShimmerEffect(to: splashView.logoImageView)
        viewModel.startWaveAnimation(on: splashView.shadowView)
        viewModel.startLabelAnimation(for: splashView.animatedLabel)
        navigateToOnboarding()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewModel.addShimmerEffect(to: splashView.logoImageView)
    }
    
    private func navigateToOnboarding() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let onboardingVC = OnboardingViewControllerBuilder.build()
            onboardingVC.modalPresentationStyle = .fullScreen
            self.present(onboardingVC, animated: true, completion: nil)
        }
    }
}
