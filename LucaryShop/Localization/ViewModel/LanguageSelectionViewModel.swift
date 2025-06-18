//
//  LanguageSelectionViewModel.swift
//  LucaryShop
//
//  Created by User on 17.06.25.
//

import UIKit

final class LanguageSelectionViewModel{
    private let coordinator:LanguageSelectionCoordinator
    private(set) var languages: [Language] = Language.allCases

    
    init(coordinator: LanguageSelectionCoordinator) {
        self.coordinator = coordinator
    }
}
