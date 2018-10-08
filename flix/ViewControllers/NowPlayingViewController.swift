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
    
    var movies : [Movie] = []
    var refreshControl: UIRefreshControl!
    
    
    
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
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 175
        fetchMovies()
    }
    @objc func didPullToRefresh(_ refreshControl:UIRefreshControl) {
        fetchMovies()
    }
    func fetchMovies() {

                let dataDictionary = try! MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
                    if let movies = movies {
                        self.movies = movies
                        self.tableView.reloadData()
                    }
                }
  
                self.activityIndicator.isHidden = true
                self.tableView.isHidden = false
                self.activityIndicator.stopAnimating()
              
                self.tableView.reloadData()
                
                self.refreshControl.endRefreshing()
                
            
        }
        
    
        
        
    
    
    // How many cells?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    // what cell is going to be in there
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.movie = movies[indexPath.row]
        return cell
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
             let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
            
        }
       
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


