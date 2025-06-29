//
//  AboutBuilder.swift
//  LucaryShop
//
//  Created by User on 29.06.25.
//

import Foundation
import UIKit
final class AboutBuilder{
    private let coordinator:AboutCoordinator
    
    init(coordinator: AboutCoordinator) {
        self.coordinator = coordinator
    }
    
    func build () -> UIViewController {
        let viewmodel = AboutViewModel(coordinator: coordinator)
        let vc  =  AboutViewController(viewModel: viewmodel)
        return vc
    }
}
