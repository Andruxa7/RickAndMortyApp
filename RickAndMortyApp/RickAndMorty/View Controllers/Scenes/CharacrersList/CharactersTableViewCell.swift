//
//  CharactersTableViewCell.swift
//  RickAndMorty
//
//  Created by Andrii Stetsenko on 04.12.2022.
//

import UIKit
import SnapKit

class CharactersTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var stickerView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .lightGray
        v.alpha = 0.5
        return v
    }()
    
    var pictureImage: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    var idLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 8)
        lbl.textAlignment = .left
        return lbl
    }()
    
    var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textAlignment = .left
        return lbl
    }()
    
    var statusLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 10)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    var speciesLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 10)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    var genderLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 10)
        lbl.textAlignment = .left
        return lbl
    }()
    
    var favoriteImage: UIImageView = {
        let imgView = UIImageView(image: UIImage(systemName: "heart.fill"))
        return imgView
    }()

    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        setupConstraintsBySnapKit()
    }
    
    func addViews() {
        contentView.addSubview(stickerView)
        contentView.addSubview(pictureImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(idLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(speciesLabel)
        contentView.addSubview(genderLabel)
        contentView.addSubview(favoriteImage)
    }
    
    func setupConstraintsBySnapKit() {
        stickerView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(11)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-15)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).offset(-11)
        }
        
        pictureImage.snp.makeConstraints { make in
            make.top.equalTo(stickerView.snp.top).offset(7)
            make.leading.equalTo(stickerView.snp.leading).offset(8)
            make.bottom.equalTo(stickerView.snp.bottom).offset(-7)
            make.width.equalTo(120)
        }
        
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(stickerView.snp.top).offset(10)
            make.leading.equalTo(pictureImage.snp.trailing).offset(8)
            make.width.equalTo(frame.size.width / 2)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(14)
            make.leading.equalTo(pictureImage.snp.trailing).offset(8)
            make.width.equalTo(frame.size.width / 2)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalTo(pictureImage.snp.trailing).offset(8)
            make.width.equalTo(frame.size.width / 2)
        }
        
        speciesLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(5)
            make.leading.equalTo(pictureImage.snp.trailing).offset(8)
            make.width.equalTo(frame.size.width / 2)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(speciesLabel.snp.bottom).offset(5)
            make.leading.equalTo(pictureImage.snp.trailing).offset(8)
            make.width.equalTo(frame.size.width / 2)
        }
        
        favoriteImage.snp.makeConstraints { make in
            make.centerY.equalTo(stickerView.snp.centerY)
            make.trailing.equalTo(stickerView.snp.trailing).offset(-10)
            make.width.equalTo(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - Private functions
    func configure(with result: Result, url: String, favoriteStatus: Bool) {
        idLabel.text = "\(result.id)"
        nameLabel.text = result.name
        statusLabel.text = result.status.rawValue
        speciesLabel.text = result.species
        genderLabel.text = result.gender.rawValue
        favoriteImage.tintColor = favoriteStatus ? .systemRed : .gray
        
        pictureImage.loadImageFrom(urlString: url)
        
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
}
