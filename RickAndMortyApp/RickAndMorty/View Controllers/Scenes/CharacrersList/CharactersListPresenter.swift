//
//  CharactersListPresenter.swift
//  RickAndMorty
//
//  Created by Andrii Stetsenko on 24.05.2023.
//

import UIKit

protocol CharactersListPresentationLogic {
    func present(results: [Result])
}

class CharactersListPresenter: CharactersListPresentationLogic {
    weak var viewController: CharactersListDisplayLogic?
    
    // MARK: Get result
    func present(results: [Result]) {
        viewController?.display(results: results)
    }
}
