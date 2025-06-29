//
//  TermsBuilder.swift
//  LucaryShop
//
//  Created by User on 29.06.25.
//

import UIKit

final class TermsBuilder {
    private var coordinator:TermsCoordinator
    
    init(coordinator: TermsCoordinator) {
        self.coordinator = coordinator
    }
    
    func build () -> UIViewController {
        let viewmodel = TermsViewModel(coordinator: coordinator)
        let vc  =  TermsViewController(viewModel: viewmodel)
        return vc
    }
    
    
}
