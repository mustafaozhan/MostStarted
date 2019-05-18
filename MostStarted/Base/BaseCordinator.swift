//
//  BaseCoordinator.swift
//  MostStarted
//
//  Created by Mustafa Ozhan on 18/05/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import Foundation
import RxSwift

class BaseCoordinator<ResultType> {
    
    typealias CoordinatonResult = ResultType
    
    let disposeBag = DisposeBag()
    
    private let identifer = UUID()
    private var childCoordinators = [UUID: Any]()
    
    private func store<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifer] = coordinator
    }
    
    private func free<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifer] = nil
    }
    
    func coordinate<T>(to coordinator: BaseCoordinator<T>) -> Observable<T> {
        store(coordinator: coordinator)
        return coordinator.start()
            .do(onNext: {[weak self] _ in self?.free(coordinator: coordinator)})
    }
    
    func start() -> Observable<ResultType>? {
        fatalError("Start method should be implemented")
    }
    
}
