//
//  BringWalkingDogUseCase.swift
//  PuppyStep
//
//  Created by Sergey on 11/10/20.
//

import Foundation

//MARK: - UseCase protocol
protocol BringWalkingDogUseCase: UseCase {
    associatedtype Params: RequestValues
    typealias Completion = InfoCompletion
    
    func execute(_ requestValues: Params, completion: @escaping Completion)
}

//MARK: - UseCase implementation
class BringWalkingDogUseCaseImpl: BringWalkingDogUseCase {

    typealias Params = DogRequestValue

    var repository: DogsRepository
    
    init(dogsRepository: DogsRepository) {
        repository = dogsRepository
    }
    
    func execute(_ requestValues: Params, completion: @escaping Completion) {
        repository.bringWalkingDog(dog: requestValues.data, completion: completion)
    }
}
