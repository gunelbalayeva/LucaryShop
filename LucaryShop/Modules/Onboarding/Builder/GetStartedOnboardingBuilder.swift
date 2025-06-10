//
//  GetStartedOnboardingBuilder.swift
//  LucaryShop
//
//  Created by User on 10.06.25.
//

import UIKit

final class GetStartedOnboardingBuilder {
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    
    func build() -> UIViewController {
        let onboardingModel = OnboardingModel(imageName: "FeaturesOnboarding",
                                              title: "Lucary hesabınız var?")
        let viewModel = GetStartedOnboardingViewModel(model: onboardingModel, cordinator: coordinator)
        let vc = GetStartedOnboardingViewController(viewModel: viewModel)
        return vc
    }
}


