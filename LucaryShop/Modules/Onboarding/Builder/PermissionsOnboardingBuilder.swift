//
//  PermissionsOnboardingBuilder.swift
//  LucaryShop
//
//  Created by User on 10.06.25.
//

import UIKit

final class PermissionsOnboardingBuilder {
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
            let onboardingModel = OnboardingModel(
                imageName: "image",
                title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. !"
            )
            let viewModel = PermissionsOnboardingViewModel(
                model: onboardingModel,
                cordinator: coordinator
            )
            return PermissionsOnboardingViewController(viewModel: viewModel)
        }
}


