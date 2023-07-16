//
//  DetailsListInteractor.swift
//  RickAndMorty
//
//  Created by Andrii Stetsenko on 25.05.2023.
//

import UIKit

protocol DetailsListBusinessLogic {
    func fetchCharacter()
}

protocol DetailsListDataStore {
    var currentCharacter: Result! { get set }
}

class DetailsListInteractor: DetailsListBusinessLogic, DetailsListDataStore {
    // MARK: - Properties
    var presenter: DetailsListPresentationLogic?
    var currentCharacter: Result!
    
    
    // MARK: - Get result
    func fetchCharacter() {
        presenter?.present(result: currentCharacter)
    }
    
}
