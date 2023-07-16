//
//  CharactersListRouter.swift
//  RickAndMorty
//
//  Created by Andrii Stetsenko on 24.05.2023.
//

import UIKit

protocol CharactersListRoutingLogic {
    func routeToDetails(character: Result, favourite: Bool)
}

protocol CharactersListDataPassing {
    var dataStore: CharactersListDataStore? { get }
}

class CharactersListRouter: CharactersListRoutingLogic, CharactersListDataPassing {
    weak var viewController: CharactersListViewController?
    var dataStore: CharactersListDataStore?
    
    func routeToDetails(character: Result, favourite: Bool) {
        let nextVC = DetailsListViewController()
        nextVC.title = "Character details"
        nextVC.currentCharacter = character
        nextVC.favoriteStatus = favourite
        
        let destinationVC = nextVC
        var destinationDS = destinationVC.router!.dataStore!
        passDataToDetailsList(source: dataStore!, destination: &destinationDS)
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // MARK: Passing data
    func passDataToDetailsList(source: CharactersListDataStore, destination: inout DetailsListDataStore) {
        let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row
        destination.currentCharacter = source.currentCharacter[selectedRow!]
    }
}
