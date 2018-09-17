//
//  SuperheroViewController.swift
//  flix
//
//  Created by Vibhu Appalaraju on 9/11/18.
//  Copyright © 2018 Vibhu Appalaraju. All rights reserved.
//

import UIKit

class SuperheroViewController: UIViewController,UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [[String: Any]] = []
    override func viewDidLoad() {
         super.viewDidLoad()
        
        collectionView.dataSource = self
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        let cellsPerLine : CGFloat = 2
        let interItemSpacingTotal = layout.minimumInteritemSpacing * (cellsPerLine - 1)
        let width = collectionView.frame.size.width / cellsPerLine - interItemSpacingTotal/cellsPerLine
        layout.itemSize = CGSize(width: width, height: width*3/2)
        fetchMovies()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        
        let movie = movies[indexPath.item]
        if let posterPathString = movie["poster_path"] as? String{
            
            let baseURLString = "https://image.tmdb.org/t/p/w500/"
            let posterURL = URL(string: baseURLString + posterPathString)!
            cell.posterImageView.af_setImage(withURL: posterURL)
            
        }
        
        return cell
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
                //self.refreshControl.endRefreshing()
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                //movies is an array of dictionary
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.movies = movies
                //self.activityIndicator.isHidden = true
              //  self.tableView.isHidden = false
                //self.activityIndicator.stopAnimating()
                
                self.collectionView.reloadData()
                
                //self.refreshControl.endRefreshing()
                //                for movie in movies {
                //                    let title = movie["title"] as! String
                //                    print(title)
                //                }
            }
        }
        
        task.resume()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
