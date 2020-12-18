//
//  DogView.swift
//  PuppyStep
//
//  Created by Sergey on 17.12.20.
//

import Foundation
import UIKit

class DogView: UIControl {
    
    //MARK: - UI
    private lazy var currentDogNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AmericanTypewriter", size: 40)
        label.textColor = UIColor.blackWhite()
        label.textAlignment = .right
        return label
    }()
    private lazy var currentDogImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private lazy var currentDogViewGesture: UIGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        return gesture
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
        
        currentDogImage.layer.cornerRadius = 0.5 * currentDogImage.bounds.size.height
        currentDogImage.clipsToBounds = true
        
        backgroundColor = UIColor.mainSecond()
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    func setData(dog: Dog) {
        currentDogNameLabel.text = dog.name
        
        currentDogImage.kf.setImage(
            with: URL(string: dog.photoUrl!),
            placeholder: UIImage(named: "LogoImage"),
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
    }
}

//MARK: - UI
private extension DogView {
    
    func addSubviews() {
        addSubview(currentDogNameLabel)
        addSubview(currentDogImage)
    }
    
    func arrangeSubviews() {
        currentDogImage.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(self.snp.height).dividedBy(1.5)
        }
        
        currentDogNameLabel.snp.makeConstraints{ make in
            make.leading.equalTo(currentDogImage.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
        }
    }
}
