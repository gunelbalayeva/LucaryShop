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
                model: OnboardingModel(imageName: "lucary1", 
                                       title: "  Lucary - Əl işi tablo, brelok, çanta və dekorativ aksesuarlar. Bura sənət sevənlərin, fərqli gözəllik axtaranların yeridir      "))
        )
        let features = FeaturesOnboardingViewController(
            viewModel: OnboardingViewModel(
                model:OnboardingModel(imageName: "lucary2", 
                                      title: "    Ad gününə və ya xüsusi anlara uyğun — şəxsi mesajla tablolar, adla breloklar, şəkillərlə çantalar. Xəyali hədiyyələri gerçəyə çevirin!    "))
            )
        let permissions = PermissionsOnboardingBuilder(coordinator: coordinator).build()
        return PageViewController(pages: [welcome, features, permissions])
    }
}
