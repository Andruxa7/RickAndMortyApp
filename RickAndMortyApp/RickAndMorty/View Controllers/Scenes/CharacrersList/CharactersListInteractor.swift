//
//  CharactersListInteractor.swift
//  RickAndMorty
//
//  Created by Andrii Stetsenko on 24.05.2023.
//

import UIKit

protocol CharactersListBusinessLogic {
    func fetchCharacters()
    func filterBy(type: CharacterFilter)
    func searchBy(searchText: String)
    func refreshItems()
}

protocol CharactersListDataStore {
    var currentCharacter: [Result] { get set }
}

class CharactersListInteractor: CharactersListBusinessLogic, CharactersListDataStore {
    // MARK: - Properties
    
    var presenter: CharactersListPresentationLogic?
    var worker: CharactersListWorker?
    var currentFilter: CharacterFilter? = nil
    var currentCharacter: [Result] = []
    
    private var networkRickAndMortyManager = NetworkRickAndMortyManager()
    private var currentPage: Int = 0
    private var results: [Result] = []
    private var filteredResults: [Result] = []
    private var favoriteResults: [Result] = []
    private var isLoading: Bool = false
    private var totalCharacters: Int = 0
    
    
    // MARK: Get Characters
    
    func fetchCharacters() {
        if currentPage > 0 {
            guard results.count < totalCharacters else { return }
        }
        guard !isLoading else { return }

        currentPage += 1
        networkRickAndMortyManager.onCompletionRickAndMortyComicsData = { [weak self] rickAndMortyData in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.results.append(contentsOf: rickAndMortyData.results)
                self.totalCharacters = rickAndMortyData.info.count
                self.isLoading = false
                
                self.refreshItems()
            }
        }
        networkRickAndMortyManager.getData(from: currentPage)
    }
    
    func refreshItems() {
        if currentFilter != nil {
            if currentFilter != .menuFavorite {
                presenter?.present(results: filteredResults)
                currentCharacter = filteredResults
            } else {
                self.favoriteResults = self.results.filter { Favorites.shared.isFavorite($0) }
                presenter?.present(results: favoriteResults)
                currentCharacter = favoriteResults
            }
        } else {
            presenter?.present(results: results)
            currentCharacter = results
        }
    }
    
    func filterBy(type: CharacterFilter) {
        switch type {
        case .menuName:
            self.filteredResults = self.results.sorted { $0.name < $1.name }
            self.currentFilter = .menuName
        case .menuAlive:
            self.filteredResults = self.results.filter { $0.status.rawValue == "Alive" }
            self.currentFilter = .menuAlive
        case .menuDead:
            self.filteredResults = self.results.filter { $0.status.rawValue == "Dead" }
            self.currentFilter = .menuDead
        case .menuUnknownStatus:
            self.filteredResults = self.results.filter { $0.status.rawValue == "unknown" }
            self.currentFilter = .menuUnknownStatus
        case .menuAlien:
            self.filteredResults = self.results.filter { $0.species == "Alien" }
            self.currentFilter = .menuAlien
        case .menuHuman:
            self.filteredResults = self.results.filter { $0.species == "Human" }
            self.currentFilter = .menuHuman
        case .menuFemail:
            self.filteredResults = self.results.filter { $0.gender.rawValue == "Female" }
            self.currentFilter = .menuFemail
        case .menuMale:
            self.filteredResults = self.results.filter { $0.gender.rawValue == "Male" }
            self.currentFilter = .menuMale
        case .menuUnknownGender:
            self.filteredResults = self.results.filter { $0.gender.rawValue == "unknown" }
            self.currentFilter = .menuUnknownGender
        case .menuFavorite:
            self.favoriteResults = self.results.filter { Favorites.shared.isFavorite($0) }
            self.currentFilter = .menuFavorite
        default:
            self.filteredResults = self.results.sorted { $0.id < $1.id }
            self.currentFilter = nil
        }
        
        refreshItems()
    }
    
    func searchBy(searchText: String) {
        self.filteredResults = self.results.filter { $0.name.lowercased().hasPrefix(searchText.lowercased()) }
        self.currentFilter = .search
        
        refreshItems()
    }
    
}
