//
//  Combine+Extensions.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Combine
import UIKit

extension Publisher {
    func sinkOnMainThread(receiveValue: @escaping ((Output) -> Void)) -> AnyCancellable {
        return self
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: receiveValue)
    }
}
