//
//  MoviesViewController.swift
//  Flicks
//
//  Created by Daniel Ku on 1/4/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var flicksNavItem: UINavigationItem!
    @IBOutlet weak var networkLabel: UILabel!
    var movies: [[String: Any]]?{
        didSet{
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.moviesTableView.reloadData()
            }
        }
    }
    var endpoint = "now_playing"
    var searchBar = UISearchBar()
    let refreshControl = UIRefreshControl()

    
   // var movieDict: [[String: Any]]?
    var filteredDict: [[String: Any]]?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "List")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "List")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        if Reachability.isConnectedToNetwork() == true{
            networkLabel.isHidden = true
        }else{
            networkLabel.isHidden = false
        }
        
        flicksNavItem.setHidesBackButton(true, animated: true)
        
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        
        refreshControl.addTarget(self, action: #selector(refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
        moviesTableView.insertSubview(refreshControl, at: 0)
        
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
                    
                    self.movies = dataDictionary["results"] as? [[String: Any]]
                    self.moviesTableView.reloadData()
                }
            }
        }
        task.resume()


        // Do any additional setup after loading the view.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredDict = searchText.isEmpty ? self.movies : self.movies?.filter({ (movie) -> Bool in
            return (movie["title"] as! String).range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        self.moviesTableView.reloadData()
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {

                    print(dataDictionary)
                    
                    self.movies = dataDictionary["results"] as! [[String : Any]]?
                    self.moviesTableView.reloadData()
                    refreshControl.endRefreshing()
                }
            }
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchBar.text!.isEmpty{
            return movies?.count ?? 0
        }else{
            return filteredDict?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MoviesTableViewCell
        
        cell.selectionStyle = .none
        
        let movie = self.searchBar.text!.isEmpty ?  movies![indexPath.row] : filteredDict![indexPath.row]
        let title = movie["title"] as! String
        let popularity = String(round((movie["popularity"] as! Double)*100)/100)
        let voteAvg = String(round((movie["vote_average"] as! Double)*100)/100)
        let releaseDate = movie["release_date"] as! String
        
        cell.movieTitle.text = title
        cell.movieVote.text = voteAvg
        cell.popularity.text = popularity
        cell.releaseDate.text = releaseDate
        
        let baseURL = "https://image.tmdb.org/t/p/w500"
        if let posterPath = movie["poster_path"] as? String{
            let imageURL = NSURL(string: baseURL + posterPath)
            cell.moviePosterImage.setImageWith(imageURL as! URL)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailFromTable"{
            let cell = sender as! UITableViewCell
            let indexPath = moviesTableView.indexPath(for: cell)
            let movie = movies![indexPath!.row]
        
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie as NSDictionary!
        }else if segue.identifier == "Collection"{
            let destinationVC = segue.destination as! MovieCollectionViewController
            destinationVC.endpoint = self.endpoint
        }
    }
}
