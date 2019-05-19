//
//  RepositoryViewModel.swift
//  MostStarted
//
//  Created by Mustafa Ozhan on 19/05/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import Foundation

class RepositoryViewModel {
    let name: String
    let description: String
    let starsCountText: String
    let url: URL
    
    init(repository: Repository) {
        self.name = repository.fullName
        self.description = repository.description
        self.starsCountText = "⭐️ \(repository.starsCount)"
        self.url = URL(string: repository.url)!
    }
}
