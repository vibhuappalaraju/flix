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
     
                MovieApiManager().popularMovies { (movies: [Movie]?, error: Error?) in
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
