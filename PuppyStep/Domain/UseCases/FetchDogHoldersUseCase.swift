//
//  FetchDogHoldersUseCase.swift
//  PuppyStep
//
//  Created by Sergey on 11/10/20.
//

import Foundation

//MARK: - UseCase protocol
protocol FetchDogHoldersUseCase: UseCase {
    typealias Completion = DogHoldersCompletion
    
    func execute(completion: @escaping Completion)
}

//MARK: - UseCase implementation
class FetchDogHoldersUseCaseImpl: FetchDogHoldersUseCase {

    var repository: DogsRepository
    
    init(dogsRepository: DogsRepository) {
        repository = dogsRepository
    }
    
    func execute(completion: @escaping Completion) {
        repository.fetchDogHolders(completion: completion)
    }
}
