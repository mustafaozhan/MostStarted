//
//  MainCoordinator.swift
//  MostStarted
//
//  Created by Mustafa Ozhan on 19/05/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import UIKit
import RxSwift

class MainCoordinator: BaseCoordinator<Void> {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        // todo
        return Observable.never()
    }
    
    
    
   
}
