//
//  WeatherView.swift
//  PuppyStep
//
//  Created by Sergey on 17.12.20.
//

import Foundation

import Foundation
import UIKit

class WeatherView: UIView {
    
    //MARK: - Views init
    private lazy var currentWeatherTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AmericanTypewriter", size: 28)
        label.textColor = UIColor.blackWhite()
        label.textAlignment = .left
        return label
    }()
    private lazy var currentWeatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        arrangeSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        arrangeSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.mainSecond()
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    func setData(weather: WeatherInfo) {
        let weatherInfo = weather.weather[0]
        currentWeatherTitleLabel.text = "\(weatherInfo.weatherTitle) \(weather.temperature)F"
        print(weatherInfo.iconUrl)

        currentWeatherImage.kf.setImage(
            with: URL(string: weatherInfo.iconUrl),
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
    }
}

//MARK: - UI
private extension WeatherView {
    
    func addSubviews() {
        addSubview(currentWeatherTitleLabel)
        addSubview(currentWeatherImage)
    }

    func arrangeSubviews() {
        currentWeatherTitleLabel.snp.makeConstraints{ make in
            make.leading.centerY.equalToSuperview().offset(30)
        }
        
        currentWeatherImage.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview().offset(20)
            make.width.height.equalTo(self.snp.height).dividedBy(1.5)
        }
    }
}
