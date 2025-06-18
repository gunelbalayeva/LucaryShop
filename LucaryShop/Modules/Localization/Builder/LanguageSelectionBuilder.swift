//
//  LanguageSelectionBuilder.swift
//  LucaryShop
//
//  Created by User on 17.06.25.
//

import Foundation
import UIKit

final class LanguageSelectionBuilder{
    private let cordinator :LanguageSelectionCoordinator
    
    init(cordinator: LanguageSelectionCoordinator) {
        self.cordinator = cordinator
    }
    
    
    func build () -> UIViewController {
        let viewmodel = LanguageSelectionViewModel(coordinator: cordinator)
        let vc  = LanguageSelectionViewController(viewModel: viewmodel, coordinator: cordinator)
        return vc
    }
}
