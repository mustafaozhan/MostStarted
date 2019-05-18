//
//  BaseCordinator.swift
//  MostStarted
//
//  Created by Mustafa Ozhan on 18/05/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import Foundation
import RxSwift

class BaseCordinator<ResultType> {
    
    typealias CordinatonResult = ResultType
    
    let disposeBag = DisposeBag()
    
    private let identifer = UUID()
    private var childCordinators = [UUID: Any]()
    
    private func store<T>(cordinator: BaseCordinator<T>){
        childCordinators[cordinator.identifer] = cordinator
    }
    
    private func free<T>(cordinator: BaseCordinator<T>){
        childCordinators[cordinator.identifer] = nil
    }
    
    func cordinate<T>(to cordinator: BaseCordinator<T>) -> Observable<T> {
        store(cordinator: cordinator)
        return cordinator.start()
            .do(onNext: {[weak self] _ in self?.free(cordinator: cordinator)})
    }
    
    func start() -> Observable<ResultType> {
        fatalError("Start method should be implemented")
    }
    
}
