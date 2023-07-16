//
//  DetailsListRouter.swift
//  RickAndMorty
//
//  Created by Andrii Stetsenko on 25.05.2023.
//

import UIKit

protocol DetailsListRoutingLogic {
    //
}

protocol DetailsListDataPassing {
    var dataStore: DetailsListDataStore? { get }
}

class DetailsListRouter: DetailsListRoutingLogic, DetailsListDataPassing {
    weak var viewController: DetailsListViewController?
    var dataStore: DetailsListDataStore?
}

