//
//  CharactersListViewController.swift
//  RickAndMorty
//
//  Created by Andrii Stetsenko on 24.05.2023.
//

import UIKit

protocol CharactersListDisplayLogic: AnyObject {
    func display(results: [Result])
}

class CharactersListViewController: UITableViewController, CharactersListDisplayLogic {
    // MARK: - Properties
    var interactor: CharactersListBusinessLogic?
    var router: (CharactersListRoutingLogic & CharactersListDataPassing)?
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    let identifierCell = "CharactersCell"
    private var results: [Result] = []
    
    
    // MARK: - initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = CharactersListInteractor()
        let presenter = CharactersListPresenter()
        let router = CharactersListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        tableView.register(CharactersTableViewCell.self, forCellReuseIdentifier: identifierCell)
        
        interactor?.fetchCharacters()
        
        navigationItemMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        interactor?.refreshItems()
    }
    
    
    // MARK: Display method
    func display(results: [Result]) {
        self.results = results
        tableView.reloadData()
    }
    
    func navigationItemMenu() {
        let defaultItem = UIAction(title: "Default", image: UIImage(systemName: "arrow.clockwise")) { (_) in
            print("filtering by Default")
            self.interactor?.filterBy(type: .defaultSettings)
        }
        
        let nameItem = UIAction(title: "name") { [self] (_) in
            print("filtering by name")
            self.interactor?.filterBy(type: .menuName)
        }
        
        let aliveItem = UIAction(title: "alive") { (_) in
            print("filtering by alive Status")
            self.interactor?.filterBy(type: .menuAlive)
        }
        
        let deadItem = UIAction(title: "dead") { (_) in
            print("filtering by dead Status")
            self.interactor?.filterBy(type: .menuDead)
        }
        
        let unknownStatusItem = UIAction(title: "unknown") { (_) in
            print("filtering by unknownStatus")
            self.interactor?.filterBy(type: .menuUnknownStatus)
        }
        
        let alienItem = UIAction(title: "alien") { (_) in
            print("filtering by alienSpecies")
            self.interactor?.filterBy(type: .menuAlien)
        }
        
        let humanItem = UIAction(title: "human") { (_) in
            print("filtering by humanSpecies")
            self.interactor?.filterBy(type: .menuHuman)
        }
        
        let femaleItem = UIAction(title: "female") { (_) in
            print("filtering by femaleGender")
            self.interactor?.filterBy(type: .menuFemail)
        }
        
        let maleItem = UIAction(title: "male") { (_) in
            print("filtering by maleGender")
            self.interactor?.filterBy(type: .menuMale)
        }
        
        let unknownGenderItem = UIAction(title: "unknown") { (_) in
            print("filtering by unknownGender")
            self.interactor?.filterBy(type: .menuUnknownGender)
        }
        
        let favoriteItem = UIAction(title: "Favorite", image: UIImage(systemName: "heart")) { (_) in
            print("filtering by Favorite!!!")
            self.interactor?.filterBy(type: .menuFavorite)
        }
        
        var submenuStatus: UIMenu {
            return UIMenu(title: "status", image: UIImage(systemName: "ellipsis"), children: [aliveItem, deadItem, unknownStatusItem])
        }
        
        var submenuSpecies: UIMenu {
            return UIMenu(title: "species", image: UIImage(systemName: "ellipsis"), children: [alienItem, humanItem])
        }
        
        var submenuGender: UIMenu {
            return UIMenu(title: "gender", image: UIImage(systemName: "ellipsis"), children: [femaleItem, maleItem, unknownGenderItem])
        }
        
        let submenuDefault = UIMenu(title: "", options: .displayInline, children: [defaultItem])
        
        var menu: UIMenu {
            return UIMenu(title: "Sort by", options: [.singleSelection], children: [submenuDefault, nameItem, submenuStatus, submenuSpecies, submenuGender, favoriteItem])
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", primaryAction: nil, menu: menu)
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath) as! CharactersTableViewCell
        
        let resultsItem = results[indexPath.row]
        let urlString = resultsItem.image
        
        cell.configure(with: resultsItem, url: urlString, favoriteStatus: Favorites.shared.isFavorite(resultsItem))
        
        return cell
    }
    
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let resultsItem = results[indexPath.row]
            self.router?.routeToDetails(character: resultsItem, favourite: Favorites.shared.isFavorite(resultsItem))
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == results.count - 1 {
            interactor?.fetchCharacters()
        }
    }
}


// MARK: - UISearchResultsUpdating Delegate
extension CharactersListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterSortByName(searchController.searchBar.text!)
    }
    
    private func filterSortByName(_ searchText: String) {
        self.interactor?.searchBy(searchText: searchText)
    }
}
