//
//  DetailsListPresenter.swift
//  RickAndMorty
//
//  Created by Andrii Stetsenko on 25.05.2023.
//

import UIKit

protocol DetailsListPresentationLogic {
    func present(result: Result)
}

class DetailsListPresenter: DetailsListPresentationLogic {
    weak var viewController: DetailsListDisplayLogic?
    
    // MARK: Get result
    func present(result: Result) {
        viewController?.display(result: result)
    }
}
