//
//  ViewController.swift
//  NewsAppCollectionView
//
//  Created by naruto kurama on 28.04.2022.
//

import UIKit
import SafariServices

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var articles = [Article]()
    private var viewModels = [NewsCollectionViewCellViewModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getData()
    }
    func getData() {
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=ef5ad57f9b4240129a949dab81830e8c"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data , error == nil else {
                return
            }
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)

                self?.articles = jsonResult.articles
                self?.viewModels = (self?.articles.compactMap({
                    NewsCollectionViewCellViewModel(title: $0.title , description: $0.description , imageURL: URL(string: $0.urlToImage ))
                }))!
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
                
            }catch {
                print("error")
            }

        }
        .resume()
    }
        
}
extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.cellIdentifier, for: indexPath) as! NewsCollectionViewCell
        cell.configure(with: viewModels[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let article = articles[indexPath.row]
        
        guard let url = URL(string: article.url ) else { return }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height / 4)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}

