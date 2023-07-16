//
//  DetailsListViewController+Extension.swift
//  RickAndMorty
//
//  Created by Andrii Stetsenko on 27.05.2023.
//

import UIKit
import SnapKit

extension DetailsListViewController {
    
    // MARK:- Add the subviews
    func addViews() {
        pictureImage.contentMode = .scaleAspectFit
        
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont(name: "AvenirNext-Bold", size: 26.0)
        nameLabel.textColor = UIColor.systemMint
        
        idLabel.textAlignment = .left
        idLabel.font = UIFont.systemFont(ofSize: 17)
        idLabel.textColor = UIColor.systemIndigo
        
        statusLabel.textAlignment = .left
        statusLabel.font = UIFont.systemFont(ofSize: 17)
        statusLabel.textColor = UIColor.systemIndigo
        
        speciesLabel.textAlignment = .left
        speciesLabel.font = UIFont.systemFont(ofSize: 17)
        speciesLabel.textColor = UIColor.systemIndigo
        
        genderLabel.textAlignment = .left
        genderLabel.font = UIFont.systemFont(ofSize: 17)
        genderLabel.textColor = UIColor.systemIndigo
        
        locationNameLabel.textAlignment = .left
        locationNameLabel.font = UIFont.systemFont(ofSize: 17)
        locationNameLabel.textColor = UIColor.systemIndigo
        
        locationURLLabel.textAlignment = .left
        locationURLLabel.font = UIFont.systemFont(ofSize: 10)
        locationURLLabel.textColor = UIColor.systemBlue
        
        view.addSubview(pictureImage)
        view.addSubview(nameLabel)
        view.addSubview(idLabel)
        view.addSubview(statusLabel)
        view.addSubview(speciesLabel)
        view.addSubview(genderLabel)
        view.addSubview(locationNameLabel)
        view.addSubview(locationURLLabel)
    }
    
    // MARK:- Setup Constraints
    func setupConstraintsBySnapKit() {
        pictureImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
            make.bottom.equalTo(nameLabel.snp.top).offset(-30)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(idLabel.snp.top).offset(-10)
        }
        
        idLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(statusLabel.snp.top).offset(-8)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(speciesLabel.snp.top).offset(-8)
        }
        
        speciesLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(genderLabel.snp.top).offset(-8)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(locationNameLabel.snp.top).offset(-8)
        }
        
        locationNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(locationURLLabel.snp.top).offset(-20)
        }
        
        locationURLLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
        }
    }
    
}
