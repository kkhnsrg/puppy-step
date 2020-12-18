//
//  DogInfoPresenter.swift
//  PuppyStep
//
//  Created by Sergey on 11/2/20.
//

import Foundation

class DogInfoPresenter: DogInfoViewPresenter {
    
    private unowned var view: DogInfoView!
    private var coordinator: AppCoordinator!
    
    //MARK: - UseCases
    private var bringDog: BringWalkingDogUseCaseImpl
    private var walkDog: WalkDogUseCaseImpl
    
    private var repository: DogsDataRepository
        
    required init(view: DogInfoView, repository: DogsDataRepository, coordinator: AppCoordinator) {
        self.view = view
        self.repository = repository
        self.coordinator = coordinator
        bringDog = BringWalkingDogUseCaseImpl(dogsRepository: repository)
        walkDog = WalkDogUseCaseImpl(dogsRepository: repository)
    }
    
    func bringCurrentDog(currentDog: Dog) {
        print("Bring dog \(currentDog.name!)")
        bringDog.execute(DogRequestValue.init(data: currentDog)) { (success) in
            if(success) {
                print("Success bringDog")
                self.view.closeModal()
            } else {
                print("Failure bringDog")
            }
        }
    }
    
    func takeSelectedDog(selectedDog: Dog) {
        walkDog.execute(DogRequestValue.init(data: selectedDog)) { (success) in
            if(success) {
                print("Success takeDog")
                self.view.closeModal()
            } else {
                print("Failure takeDog")
            }
        }
        view.closeModal()
    }
}
