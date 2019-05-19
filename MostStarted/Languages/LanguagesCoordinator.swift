//
//  LanguagesCoordinator.swift
//  MostStarted
//
//  Created by Mustafa Ozhan on 19/05/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import UIKit
import RxSwift

enum LanguagesCoordinationResult {
    case language(String)
    case cancel
}

class LanguagesCoordinator: BaseCoordinator<LanguagesCoordinationResult> {
    private let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<CoordinatonResult> {
        let viewController = LanguagesViewController.initFromStoryboard(name: "Main")
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let viewModel = LanguagesViewModel()
        viewController.viewModel = viewModel
        
        let cancel = viewModel.didCancel.map { _ in CoordinatonResult.cancel}
        let language = viewModel.didSelectLanguage.map { CoordinatonResult.language($0) }
        
        rootViewController.present(navigationController, animated: true)
        
        return Observable.merge(cancel, language)
            .take(1)
            .do(onNext: { [weak self] _ in self?.rootViewController.dismiss(animated: true) })
    }
}
