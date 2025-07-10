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
                imageName: "lucary3",
                title: "Lucary komandası olaraq yerli ustaların əl işini daha geniş auditoriyaya çatdırırıq. Hər sifariş həm də sənətə dəstək deməkdir"
            )
            let viewModel = PermissionsOnboardingViewModel(
                model: onboardingModel,
                cordinator: coordinator
            )
            return PermissionsOnboardingViewController(viewModel: viewModel)
        }
}


