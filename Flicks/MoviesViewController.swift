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

var sortControl = "NowPlaying"

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var flicksNavItem: UINavigationItem!
    @IBOutlet weak var networkLabel: UILabel!
    var movies: [NSDictionary]?
    let defaults = UserDefaults.standard


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Reachability.isConnectedToNetwork() == true{
            networkLabel.isHidden = true
        }else{
            networkLabel.isHidden = false
        }
        
        if let sort = defaults.string(forKey: "sortControl"){
            sortControl = sort
        }
        
        flicksNavItem.setHidesBackButton(true, animated: true)
        
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
        moviesTableView.insertSubview(refreshControl, at: 0)
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        var url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")!
        
        if sortControl == "Popular"{
            url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)")!
        }else if sortControl == "TopRated"{
            url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)")!
        }
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    
                    print(dataDictionary)
                    
                    self.movies = dataDictionary["results"] as? [NSDictionary]
                    self.moviesTableView.reloadData()
                }
            }
        }
        task.resume()


        // Do any additional setup after loading the view.
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
                    
                    self.movies = dataDictionary["results"] as? [NSDictionary]
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
        if let movies = movies{
            return movies.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MoviesTableViewCell
        
        let movie = movies![indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        let popularity = String(round((movie["popularity"] as! Double)*100)/100)
        let voteAvg = String(round((movie["vote_average"] as! Double)*100)/100)
        let releaseDate = movie["release_date"] as! String
        let posterPath = movie["poster_path"] as! String

        let baseURL = "https://image.tmdb.org/t/p/w500"
        
        let imageURL = NSURL(string: baseURL + posterPath)
        
        cell.movieTitle.text = title
        cell.overviewLabel.text = overview
        cell.movieVote.text = voteAvg
        cell.popularity.text = popularity
        cell.releaseDate.text = releaseDate
        cell.moviePosterImage.setImageWith(imageURL as! URL)

        return cell
    }
}
