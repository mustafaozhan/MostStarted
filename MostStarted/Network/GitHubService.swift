//
//  GitHubService.swift
//  MostStarted
//
//  Created by Mustafa Ozhan on 18/05/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum ServiceError: Error {
    case cannotParse
}

class GitHubService {
    
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func getLanguageList() -> Observable<[String]> {
        return Observable.just([
            "Swift",
            "Kotlin",
            "Java",
            "C",
            "C++",
            "Python"
            ])
    }
    
    func getMostStartedRepositories(byLanguage language: String) -> Observable<[Repository]> {
        let encodedLanguage = language.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let url = URL(string: "https://api.github.com/search/repositories?q=language:\(encodedLanguage)&sort=stars")!
        return session.rx
            .json(url: url)
            .flatMap { json throws -> Observable<[Repository]> in
                guard
                    let json = json as? [String: Any],
                    let itemsJSON = json["items"] as? [[String: Any]]
                    else { return Observable.error(ServiceError.cannotParse) }
                
                let repositories = itemsJSON.compactMap(Repository.init)
                return Observable.just(repositories)
        }
    }
}
