//
//  DetailsListViewController.swift
//  RickAndMorty
//
//  Created by Andrii Stetsenko on 25.05.2023.
//

import UIKit

protocol DetailsListDisplayLogic: AnyObject {
    func display(result: Result)
}

class DetailsListViewController: UIViewController, DetailsListDisplayLogic {
    // MARK: - Properties
    var interactor: DetailsListBusinessLogic?
    var router: (DetailsListRoutingLogic & DetailsListDataPassing)?

    var pictureImage = UIImageView()
    var nameLabel = UILabel()
    var idLabel = UILabel()
    var statusLabel = UILabel()
    var speciesLabel = UILabel()
    var genderLabel = UILabel()
    var locationNameLabel = UILabel()
    var locationURLLabel = UILabel()
    
    var currentCharacter: Result!
    var favoriteStatus: Bool = false
    
    
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
        let interactor = DetailsListInteractor()
        let presenter = DetailsListPresenter()
        let router = DetailsListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        if Favorites.shared.isFavorite(currentCharacter) {
            favoriteStatus = true
        }
        
        setUpFavoriteButton()
        addViews()
        setupConstraintsBySnapKit()
        interactor?.fetchCharacter()
    }
    
    
    func display(result: Result) {
        let item = result
        nameLabel.text = item.name
        idLabel.text = "id: \(item.id)"
        statusLabel.text = "status: \(item.status.rawValue)"
        speciesLabel.text = "species: \(item.species)"
        genderLabel.text = "gender: \(item.gender.rawValue)"
        locationNameLabel.text = "location name: \(item.location.name)"
        locationURLLabel.text = "location URL: \(item.location.url)"
        
        pictureImage.loadImageFrom(urlString: item.image)
    }
    
    
    // MARK: - Private functions
    private func setUpFavoriteButton() {
        let favoriteBtn = UIButton(type: .custom)
        favoriteBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        favoriteBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        favoriteBtn.tintColor = favoriteStatus ? .systemRed : .lightGray
        favoriteBtn.tag = currentCharacter.id
        favoriteBtn.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)
        
        let favoriteBarButton = UIBarButtonItem(customView: favoriteBtn)
        navigationItem.rightBarButtonItem = favoriteBarButton
    }
    
    @objc private func favoriteButtonPressed(_ sender: UIButton) {
        favoriteStatus.toggle()
        sender.tintColor = favoriteStatus ? .systemRed : .lightGray
        
        Favorites.shared.toggleFavorite(currentCharacter)
    }
    
}
