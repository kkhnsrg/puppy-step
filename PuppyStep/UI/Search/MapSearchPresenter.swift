//
//  SearchPresenter.swift
//  PuppyStep
//
//  Created by Sergey on 10/28/20.
//

import Foundation
import RxSwift

class MapSearchPresenter: MapSearchViewPresenter {
    
    private unowned var view: MapSearchView!
    private var coordinator: AppCoordinator!
    
    //MARK: - UseCases
    private var fetchDogHolders: FetchDogHoldersUseCaseImpl
    private var fetchCurrentDog: FetchCurrentDogUseCaseImpl
    private var fetchCurrentWeather: FetchCurrentWeatherUseCaseImpl

    private var repository: DogsDataRepository
    
    private let disposeBag = DisposeBag()
    
    required init(view: MapSearchView, repository: DogsDataRepository, coordinator: AppCoordinator) {
        self.view = view
        self.repository = repository
        self.coordinator = coordinator
        fetchDogHolders = FetchDogHoldersUseCaseImpl(dogsRepository: repository)
        fetchCurrentDog = FetchCurrentDogUseCaseImpl(dogsRepository: repository)
        fetchCurrentWeather = FetchCurrentWeatherUseCaseImpl()
    }
    
    func getDogHoldersData() {
        fetchDogHolders.execute { (dogHolders, success) in
            if (success) {
                dogHolders.isEmpty
                    ? self.view.showMessage(message: "Can't find any dog holders. Do you want retry?")
                    : self.view.showDogHoldersData(dogHolders: dogHolders)
            } else {
                print("Error with getting all dog holders")
                self.view.showMessage(message: "Error with getting all dog holders.")
            }
        }
    }
    
    func navigateToDetailsScreen(selectedDogHolder: DogHolder) {
        coordinator.navigateToDetails(dogHolder: selectedDogHolder)
    }
    
    func navigateToDogInfoScreen(dog: Dog) {
        coordinator.navigateToDogInfo(dog: dog, isWalkingDog: true)
    }
    
    func getCurrentWeather() {
        fetchCurrentWeather.execute(CityRequestValue.init(data: "Minsk")) { (weather, success) in
            guard success else { return }
            self.view.showWeatherInfo(weather: weather)
        }
    }
    
    func getCurrentDog() {
        fetchCurrentDog.execute { (dog, success) in
            if (success) {
                guard let currentDog = dog else {
                    return
                }
                self.view.showCurrentDog(currentDog: currentDog)
            } else {
                print("Get current dog failed")
            }
        }
    }
    
}
