//
//  WalkDogUseCase.swift
//  PuppyStep
//
//  Created by Sergey on 11/10/20.
//

import Foundation

//MARK: - UseCase protocol
protocol WalkDogUseCase: UseCase {
    associatedtype Params: RequestValues
    typealias Completion = InfoCompletion
    
    func execute(_ requestValues: Params, completion: @escaping Completion)
}

//MARK: - UseCase implementation
class WalkDogUseCaseImpl: WalkDogUseCase {

    typealias Params = DogRequestValue

    var repository: DogsRepository
    
    init(dogsRepository: DogsRepository) {
        repository = dogsRepository
    }
    
    func execute(_ requestValues: Params, completion: @escaping Completion) {
        repository.walkDog(dog: requestValues.data, completion: completion)
    }
}
