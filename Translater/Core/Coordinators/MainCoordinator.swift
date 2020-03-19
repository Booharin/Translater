//
//  MainCoordinator.swift
//  Translater
//
//  Created by 18421820 on 17.03.2020.
//  Copyright © 2020 Umbrella. All rights reserved.
//

import UIKit

final class MainCoordinator: BaseCoordinator {
    
    var rootController: UINavigationController?
    var onFinishFlow: (() -> Void)?
    
    override func start() {
        showMainModule()
    }
    
    private func showMainModule() {
        let controller = MainViewController()
        controller.coordinator = self
        
        //MARK: - Pass to DescriptionController
        controller.toWordDescription = { meaning in
            let descriptionController = DescriptionViewController()
            descriptionController.meaning = meaning
            controller.navigationController?.pushViewController(descriptionController,
                                                                animated: true)
        }
        
        let rootController = UINavigationController(rootViewController: controller)
        setAsRoot(rootController)
        self.rootController = rootController
    }
}
