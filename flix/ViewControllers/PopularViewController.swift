//
//  PopularViewController.swift
//  flix
//
//  Created by Vibhu Appalaraju on 10/6/18.
//  Copyright © 2018 Vibhu Appalaraju. All rights reserved.
//

import UIKit
import AlamofireImage

class PopularViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var popularTableView: UITableView!
    
    var movies : [Movie] = []
    var refreshControl: UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popularTableView.isHidden = true
        refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(PopularViewController.didPullToRefresh(_:)), for: .valueChanged)
        popularTableView.insertSubview(refreshControl, at: 0)
        popularTableView.dataSource = self
        popularTableView.delegate =  self
        //popularTableView.rowHeight = UITableViewAutomaticDimension
        popularTableView.estimatedRowHeight = 175
        fetchPopularMovies()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func didPullToRefresh(_ refreshControl:UIRefreshControl) {
        fetchPopularMovies()
    }
    
    func fetchPopularMovies(){
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
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
                
                let dataDictionary = try! MovieApiManager().popularMovies { (movies: [Movie]?, error: Error?) in
                    if let movies = movies {
                        self.movies = movies
                        self.popularTableView.reloadData()
                    }
                }
                
                
                
                //self.activityIndicator.isHidden = true
                self.popularTableView.isHidden = false
                //self.activityIndicator.stopAnimating()
                
                self.popularTableView.reloadData()
                
                self.refreshControl.endRefreshing()
                
            }
        }
        
        task.resume()
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell =  tableView.dequeueReusableCell(withIdentifier: "PopularMovieCell", for: indexPath) as! PopularMovieCell
        
        cell.movie = movies[indexPath.row]
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
