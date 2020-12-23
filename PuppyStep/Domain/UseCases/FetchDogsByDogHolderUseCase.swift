//
//  FetchDogsByDogHolderUseCase.swift
//  PuppyStep
//
//  Created by Sergey on 11/10/20.
//

import Foundation

//MARK: - UseCase protocol
protocol FetchDogsByDogHolderUseCase: UseCase {
    associatedtype Params: RequestValues
    typealias Completion = DogsCompletion
    
    func execute(_ requestValues: Params, completion: @escaping Completion)
}

//MARK: - UseCase implementation
class FetchDogsByDogHolderUseCaseImpl: FetchDogsByDogHolderUseCase {
    
    typealias Params = DogHolderRequestValue
    
    var repository: DogsRepository

    init(dogsRepository: DogsRepository) {
        repository = dogsRepository
    }
    
    func execute(_ requestValues: Params, completion: @escaping Completion) {
        repository.fetchDogs(dogHolderName: requestValues.data, completion: completion)
    }
}
