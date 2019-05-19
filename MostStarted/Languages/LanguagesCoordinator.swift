//
//  LanguagesCoordinator.swift
//  MostStarted
//
//  Created by Mustafa Ozhan on 19/05/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import UIKit

enum LanguagesCoordinationResult {
    case language(String)
    case cancel
}

class LanguagesCoordinator: BaseCoordinator<LanguagesCoordinationResult> {
    private let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
}
