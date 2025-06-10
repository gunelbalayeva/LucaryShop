//
//  GetStartedOnboardingViewModel.swift
//  LucaryShop
//
//  Created by User on 10.06.25.
//

import Foundation
import UIKit

final class GetStartedOnboardingViewModel {
    
    private let model: OnboardingModel
    private let cordinator :AppCoordinator
    
    init(model: OnboardingModel, cordinator: AppCoordinator) {
        self.model = model
        self.cordinator = cordinator
    }
    var image: UIImage? {
        UIImage(named: model.imageName)
    }
    
    var titleText: String {
        model.title
    }
}
