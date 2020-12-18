//
//  DetailsPresenter.swift
//  PuppyStep
//
//  Created by Sergey on 10/29/20.
//

import Foundation

class DetailsPresenter: DetailsViewPresenter {

    private unowned var view: DetailsView!
    private var coordinator: AppCoordinator!
        
    //MARK: - UseCases
    private var fetchDogs: FetchDogsByDogHolderUseCaseImpl
    
    private var repository: DogsDataRepository
    
    required init(view: DetailsView, repository: DogsDataRepository, coordinator: AppCoordinator) {
        self.view = view
        self.repository = repository
        self.coordinator = coordinator
        fetchDogs = FetchDogsByDogHolderUseCaseImpl(dogsRepository: repository)
    }
    
    func getDogsData(dogHolderName: String) {
        print("getAllDogsByHolderName")
        fetchDogs.execute(DogHolderRequestValue.init(data: dogHolderName)) { (dogs, success) in
            self.view.hideRefreshControl()
            if (success) {
                if (dogs.isEmpty) {
                    self.view.showEmptyDataView()
                } else {
                    self.view.hideEmptyDataView()
                    self.view.showDogsData(dogs: dogs)
                }
            } else {
                print("Error with getting all dogs info by holder name")
            }
        }
    }
    
    func navigateToDogInfoScreen(selectedDog: Dog) {
        coordinator.navigateToDogInfo(dog: selectedDog, isWalkingDog: false)
    }
    
}
