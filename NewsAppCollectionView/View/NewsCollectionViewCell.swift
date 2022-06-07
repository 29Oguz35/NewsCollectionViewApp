//
//  NewsCollectionViewCell.swift
//  NewsAppCollectionView
//
//  Created by naruto kurama on 29.04.2022.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "NewsCollectionViewCell"
    
    private let imageNew : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 12
        img.backgroundColor = .blue
        
        return img
    }()
    private let newsTitleLabel : UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        lbl.numberOfLines = 0
        return lbl
    }()
    private let newsDescriptionLabel : UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .light)
        lbl.numberOfLines = 0
        return lbl
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createView()
       
    }
    fileprivate func createView() {
        
        addSubview(imageNew)
        addSubview(newsTitleLabel)
        addSubview(newsDescriptionLabel)
        
        imageNew.anchor(top: topAnchor, bottom: bottomAnchor, leading: newsTitleLabel.trailingAnchor, trailing: trailingAnchor, paddingTop: 5, paddingBottom: -5, paddingLeft: 5, paddingRight: -5, width: frame.width/2, height: frame.height)
        
        newsTitleLabel.anchor(top: topAnchor, bottom: newsDescriptionLabel.topAnchor, leading: leadingAnchor, trailing: imageNew.leadingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 5, paddingRight: -5, width: frame.width/2.5, height: frame.height / 4)
        
        newsDescriptionLabel.anchor(top: newsTitleLabel.bottomAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: imageNew.leadingAnchor, paddingTop: 5, paddingBottom: -5, paddingLeft: 5, paddingRight: -5, width: frame.width/2.5, height: 0)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with viewModels : NewsCollectionViewCellViewModel) {
        
        newsTitleLabel.text = viewModels.title
        newsDescriptionLabel.text = viewModels.description
        
        if let data = viewModels.imageData {
            imageNew.image = UIImage(data: data)
        }
        else if let url = viewModels.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data , error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    self?.imageNew.image = UIImage(data: data)
                }

            }.resume()
        }
    }
}
