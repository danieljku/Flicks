//
//  MovieCollectionViewController.swift
//  Flicks
//
//  Created by Daniel Ku on 1/12/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MovieCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var networkLabel: UILabel!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var movies: [[String: Any]]?{
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    var filteredDict: [[String: Any]]?
    var endpoint = "now_playing"
    var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Reachability.isConnectedToNetwork() == true{
            networkLabel.isHidden = true
        }else{
            networkLabel.isHidden = false
        }

        self.navigationController!.navigationBar.tintColor = UIColor.white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        // Do any additional setup after loading the view.
        
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 10, 0)
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")!
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    
                    print(dataDictionary)
                    
                    self.movies = dataDictionary["results"] as! [[String : Any]]?
                    self.collectionView.reloadData()
                }
            }
        }
        task.resume()

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredDict = searchText.isEmpty ? self.movies : self.movies?.filter({ (movie) -> Bool in
            return (movie["title"] as! String).range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        self.collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.searchBar.text!.isEmpty{
            return movies?.count ?? 0
        }else{
            return filteredDict?.count ?? 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! MoviesCollectionViewCell
        
        let movie = self.searchBar.text!.isEmpty ? movies![indexPath.row] : filteredDict![indexPath.row]
        
        let baseURL = "https://image.tmdb.org/t/p/w500"
        if let posterPath = movie["poster_path"] as? String{
            let imageURL = NSURL(string: baseURL + posterPath)
            cell.moviePosterImage.setImageWith(imageURL as! URL)
        }
        return cell
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "DetailFromTable"{
//            let cell = sender as! UICollectionViewCell
//            let indexPath = collectionView.indexPath(for: cell)
//            let movie = movies![indexPath!.row]
//            
//            let detailViewController = segue.destination as! DetailViewController
//            detailViewController.movie = movie
//        }
//    }
}
