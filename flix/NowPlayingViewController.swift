//
//  NowPlayingViewController.swift
//  flix
//
//  Created by Vibhu Appalaraju on 9/4/18.
//  Copyright © 2018 Vibhu Appalaraju. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    

    @IBOutlet weak var tableView: UITableView!
    var movies : [[String: Any]] = []
    var refreshControl: UIRefreshControl!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.isHidden = false
        self.tableView.isHidden = true
        self.activityIndicator.startAnimating();
        refreshControl = UIRefreshControl()
       
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        tableView.delegate =  self
        fetchMovies()
    }
    @objc func didPullToRefresh(_ refreshControl:UIRefreshControl) {
        fetchMovies()
    }
    func fetchMovies() {
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            
            
            //parse and got data back
            if let error =  error {
                let alertController = UIAlertController(title: "Cannot find movies", message: "The Internet connection appears to be offline", preferredStyle: .alert)
                let tryAction = UIAlertAction(title: "Try again", style: .default) { (action) in
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                // add the cancel action to the alertController
                alertController.addAction(tryAction)
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
                self.refreshControl.endRefreshing()
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                //movies is an array of dictionary
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.movies = movies
                self.activityIndicator.isHidden = true
                self.tableView.isHidden = false
                self.activityIndicator.stopAnimating()
              
                self.tableView.reloadData()
                
                self.refreshControl.endRefreshing()
                //                for movie in movies {
                //                    let title = movie["title"] as! String
                //                    print(title)
                //                }
            }
        }
        
        task.resume()
        
        
    }
    
    // How many cells?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    // what cell is going to be in there
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        
        
        let posterPathString = movie["poster_path"] as! String
        let baseURLString = "https://image.tmdb.org/t/p/w500/"
        let posterURL = URL(string: baseURLString + posterPathString)!
        cell.posterImageView.af_setImage(withURL: posterURL)
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
