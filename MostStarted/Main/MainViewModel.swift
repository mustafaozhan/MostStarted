//
//  MainViewModel.swift
//  MostStarted
//
//  Created by Mustafa Ozhan on 19/05/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import Foundation
import RxSwift

class MainViewModel {
    
    // MARK: - Inputs
    let setCurrentLanguage: AnyObserver<String>
    let chooseLanguage: AnyObserver<Void>
    let selectRepository: AnyObserver<RepositoryViewModel>
    let reload: AnyObserver<Void>
    
    // MARK: - Outputs
    
    let repositories: Observable<[RepositoryViewModel]>
    let title: Observable<String>
    let alertMessage: Observable<String>
    let showRepository: Observable<URL>
    let showLanguageList: Observable<Void>
    
    init(initialLanguage: String, gitHubService: GitHubService = GitHubService()) {
        
        let reload = PublishSubject<Void>()
        self.reload = reload.asObserver()
        
        let currentLanguage = BehaviorSubject<String>(value: initialLanguage)
        self.setCurrentLanguage = currentLanguage.asObserver()
        
        self.title = currentLanguage.asObservable()
            .map { "\($0)" }
        
        let alertMessage = PublishSubject<String>()
        self.alertMessage = alertMessage.asObservable()
        
        self.repositories = Observable.combineLatest( reload, currentLanguage) { _, language in language }
            .flatMapLatest { language in
                gitHubService.getMostStartedRepositories(byLanguage: language)
                    .catchError { error in
                        alertMessage.onNext(error.localizedDescription)
                        return Observable.empty()
                }
            }
            .map { repositories in repositories.map(RepositoryViewModel.init) }
        
        let selectRepository = PublishSubject<RepositoryViewModel>()
        self.selectRepository = selectRepository.asObserver()
        self.showRepository = selectRepository.asObservable()
            .map { $0.url }
        
        let chooseLanguage = PublishSubject<Void>()
        self.chooseLanguage = chooseLanguage.asObserver()
        self.showLanguageList = chooseLanguage.asObservable()
        
    }
    
}
