//
//  MainCoordinator.swift
//  MostStarted
//
//  Created by Mustafa Ozhan on 19/05/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import UIKit
import RxSwift
import SafariServices

class MainCoordinator: BaseCoordinator<Void> {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewModel = MainViewModel.init(initialLanguage: "Swift")
        let viewController = MainViewController.initFromStoryboard(name: "Main")
        let navigationController = UINavigationController(rootViewController: viewController)
        
        viewController.viewModel = viewModel
        
        viewModel.showRepository
            .subscribe(onNext: {[weak self] in self?.showRepository(by: $0, in: navigationController)})
            .disposed(by: disposeBag)
        
        viewModel.showLanguages
            .flatMap { [weak self] _ -> Observable <String?> in
                guard let `self` = self else { return .empty() }
                return self.showLanguages(on: viewController)
            }
            .filter { $0 != nil }
            .map { $0! }
            .bind(to: viewModel.setCurrentLanguage)
            .disposed(by: disposeBag)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
    
    private func showRepository(by url: URL, in navigationController: UINavigationController) {
        let safariViewController = SFSafariViewController(url: url)
        navigationController.pushViewController(safariViewController, animated: true)
    }
    
    private func showLanguages(on rootViewController: UIViewController) -> Observable<String?> {
        let languagesCoordinator = LanguagesCoordinator(rootViewController: rootViewController)
        return coordinate(to: languagesCoordinator)
            .map { result in
                switch result {
                case .language(let language): return language
                case .cancel: return nil
                }
        }
    }
}
