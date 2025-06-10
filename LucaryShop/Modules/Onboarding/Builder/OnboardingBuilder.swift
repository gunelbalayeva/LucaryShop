//
//  OnboardingBuilder.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
import UIKit

final class OnboardingViewControllerBuilder {
    
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let welcome = WelcomeOnboardingViewController(
            viewModel: OnboardingViewModel(
                model: OnboardingModel(imageName: "GetStartedOnboarding", 
                                       title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. !"))
        )
        let features = FeaturesOnboardingViewController(
            viewModel: OnboardingViewModel(
                model:OnboardingModel(imageName: "FeaturesOnboarding", 
                                      title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. !"))
            )
        let permissions = PermissionsOnboardingBuilder(coordinator: coordinator).build()
        return PageViewController(pages: [welcome, features, permissions])
    }
}
