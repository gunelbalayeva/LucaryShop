//
//  Coordinator.swift
//  LucaryShop
//
//  Created by User on 30.06.25.
//

import Foundation
import UIKit
protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    func start(with categoryId: String) 
}
