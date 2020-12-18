//
//  MapViewController.swift
//  PuppyStep
//
//  Created by Sergey on 10/9/20.
//

import Foundation
import RxSwift
import RxCocoa
import MapKit
import Kingfisher

class MapSearchViewController: UIViewController {

    private var presenter: MapSearchViewPresenter!

    private let disposeBag = DisposeBag()
    
    private var currentDog: Dog?
    
    //MARK: - Views init
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        let initialLocation = CLLocation(latitude: 53.893009, longitude: 27.567444)
        mapView.centerToLocation(initialLocation, regionRadius: 12000)
        return mapView
    }()
    private let messageAlert: UIAlertController = {
        let alert = UIAlertController(
            title: "Warning!",
            message: "",
            preferredStyle: .alert
        )
        return alert
    }()
    private lazy var currentDogView: DogView = {
        return DogView()
    }()
    private lazy var currentWeatherView: WeatherView = {
        return WeatherView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        addSubviews()
        arrangeSubviews()
        setupActions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        currentDogView.roundTopCorners(cornerRadius: 50)
        currentWeatherView.roundBottomCorners(cornerRadius: 50)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentDogView.isHidden = true
        currentWeatherView.isHidden = true
        self.currentDog = nil
        
        presenter.getDogHoldersData()
        presenter.getCurrentDog()
        presenter.getCurrentWeather()
    }
    
}

//MARK: - UI
private extension MapSearchViewController {
    
    func setupView() {
        mapView.delegate = self
    }
    
    func addSubviews() {
        view.addSubview(mapView)
        view.addSubview(currentDogView)
        view.addSubview(currentWeatherView)
    }

    func arrangeSubviews() {
        
        mapView.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        currentDogView.snp.makeConstraints{ make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.view.snp.centerY).offset(self.view.bounds.height/3)
        }
        
        currentWeatherView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(self.view.snp.centerY).offset(self.view.bounds.height / -3)
        }
    }
    
    func setupActions() {
        
        let alertAction = UIAlertAction(title: "Retry", style: .default) { action in
            self.presenter.getDogHoldersData()
        }
        messageAlert.addAction(alertAction)
        
        currentDogView.rx.controlEvent(.touchUpInside)
            .bind(onNext: { recognizer in
                self.presenter.navigateToDogInfoScreen(dog: self.currentDog!)
            })
            .disposed(by: disposeBag)
    }
}

//MARK: - View contract
extension MapSearchViewController: MapSearchView {
        
    func configure(presenter: MapSearchViewPresenter) {
        self.presenter = presenter
    }
    
    func showDogHoldersData(dogHolders: [DogHolder]) {
        mapView.addAnnotations(dogHolders)
    }
    
    func showMessage(message: String) {
        messageAlert.message = message
        self.present(messageAlert, animated: true, completion: nil)
    }
    
    func showCurrentDog(currentDog: Dog) {
        self.currentDog = currentDog
        currentDogView.setData(dog: currentDog)
        currentDogView.isHidden = false
    }
    
    func showWeatherInfo(weather: WeatherInfo) {
        currentWeatherView.setData(weather: weather)
        currentWeatherView.isHidden = false
    }
}


//MARK: - MKMapViewDelegate
extension MapSearchViewController: MKMapViewDelegate {
    
    func mapView(
        _ mapView: MKMapView,
        viewFor annotation: MKAnnotation
    ) -> MKAnnotationView? {
        
        guard let annotation = annotation as? DogHolder else {
            return nil
        }
        
        let identifier = "dogholder"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(
            withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            
            view = MKMarkerAnnotationView(
                annotation: annotation,
                reuseIdentifier: identifier)
            view.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            button.setImage(UIImage(named: "LogoImage"), for: .normal)
            button.rx.tap
                .bind {
                    self.presenter.navigateToDetailsScreen(selectedDogHolder: annotation)
                }
                .disposed(by: disposeBag)
            view.rightCalloutAccessoryView = button
        }
        view.glyphImage = UIImage(named: "LogoImage")
        view.markerTintColor = UIColor.mainSecond()
        return view
    }
}
