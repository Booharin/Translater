//
//  ApplicationCoordinator.swift
//  Translater
//
//  Created by Booharin on 17.03.2020.
//  Copyright © 2020 Umbrella. All rights reserved.
//

import Foundation

final class ApplicationCoordinator: BaseCoordinator {
    
    override func start() {
        toMain()
    }
    
    private func toMain() {
        let coordinator = MainCoordinator()
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
