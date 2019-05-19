//
//  LanguagesViewModel.swift
//  MostStarted
//
//  Created by Mustafa Ozhan on 19/05/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import RxSwift

class LanguagesViewModel {
    
    let selectLanguage: AnyObserver<String>
    let cancel: AnyObserver<Void>
    
    let languages: Observable<[String]>
    let didSelectLanguage: Observable<String>
    let didCancel: Observable<Void>
    
    init(gitHubService: GitHubService = GitHubService()) {
        self.languages = gitHubService.getLanguageList()
        
        let selectLanguage = PublishSubject<String>()
        self.selectLanguage = selectLanguage.asObserver()
        self.didSelectLanguage = selectLanguage.asObservable()
        
        let cancel = PublishSubject<Void>()
        self.cancel = cancel.asObserver()
        self.didCancel = cancel.asObservable()
    }
}
