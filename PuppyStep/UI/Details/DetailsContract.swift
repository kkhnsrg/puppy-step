//
//  DetailsContract.swift
//  PuppyStep
//
//  Created by Sergey on 10/28/20.
//

import Foundation

//MARK: - View contract
protocol DetailsView: AnyObject {
    func configure(presenter: DetailsViewPresenter, dogHolder: DogHolder)
    func showDogsData(dogs: [Dog])
    func hideRefreshControl()
    func showEmptyDataView()
    func hideEmptyDataView()
}

//MARK: - Presenter contract
protocol DetailsViewPresenter {
    init(view: DetailsView, repository: DogsDataRepository, coordinator: AppCoordinator)
    func getDogsData(dogHolderName: String)
    func navigateToDogInfoScreen(selectedDog: Dog)
}
