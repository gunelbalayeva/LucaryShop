//
//  HomeBuilder.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
import UIKit
final class HomeBuilder{
    private weak var coordinator: HomeCoordinator?
    private let productService: ProductService
    private let categoryService: CategoryService
    private let companyService :CompanyService
    
    init(coordinator: HomeCoordinator? = nil,
         productService: ProductService,
         categoryService: CategoryService,
         companyService: CompanyService) {
        self.coordinator = coordinator
        self.productService = productService
        self.categoryService = categoryService
        self.companyService = companyService
    }
    
    func build () -> UIViewController {
        let viewmodel = HomeViewModel(coordinator: coordinator,
                                      productService: productService,
                                      categoryService: categoryService,
                                      companyService: companyService)
        let vc  = HomeViewController(homeViewModel: viewmodel)
        return vc
    }
}
