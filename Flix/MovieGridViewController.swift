//
//  MovieGridViewController.swift
//  Flix
//
//  Created by Jorge Garcia on 9/30/20.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    //properties -- outlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // movies property
    var movies = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // layout to configure the grid and cells
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        
        //pixels betweeen the rows
        layout.minimumLineSpacing = 10
        
        layout.minimumInteritemSpacing = 10
        
        //this is how you get the width of the phone
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        //if I want 2 posters then ---- width /2
        
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        // Download the comic book movies only from the API
        
        // Searched for movies similar to infinity war on the movieDb
        var url = URL(string: "https://api.themoviedb.org/3/movie/299536/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=3")!
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        var session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        var task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            self.movies = dataDictionary["results"] as! [[String:Any]]
            
            // this needs to happen to reload the data once the data is downloaded
            self.collectionView.reloadData()
            
            //detele these before pushing
//            print(dataDictionary)
//            print("----------------- testing to see the difference ---------------")
//            print(self.movies)
           }
        }
        task.resume()
        //testing here
        
        // this can absolutely be optimized in a functioon but that comes later
        // Re-form the URL and request from the API but now a different page since just one was dissapointing
        // instead of replacing the self.movies dicitonary, just append to it with self.movies.append(contentsOf: <the new data pulled>)
        url = URL(string: "https://api.themoviedb.org/3/movie/299536/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=2")!
        request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            self.movies.append(contentsOf: dataDictionary["results"] as! [[String:Any]])
            
            // this needs to happen to reload the data once the data is downloaded
            self.collectionView.reloadData()
            
            //detele these before pushing
//            print(dataDictionary)
//            print("----------------- testing to see the difference ---------------")
//            print(self.movies)
           }
        }
        task.resume()
        // this can absolutely be optimized in a functioon but that comes later
        // Re-form the URL and request from the API but now a different page since just one was dissapointing
        // instead of replacing the self.movies dicitonary, just append to it with self.movies.append(contentsOf: <the new data pulled>)
        url = URL(string: "https://api.themoviedb.org/3/movie/299536/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1")!
        request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            self.movies.append(contentsOf: dataDictionary["results"] as! [[String:Any]])
            
            // this needs to happen to reload the data once the data is downloaded
            self.collectionView.reloadData()
            
            //detele these before pushing
//            print(dataDictionary)
//            print("----------------- testing to see the difference ---------------")
//            print(self.movies)
           }
        }
        task.resume()
    }
    
    
    //functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = true
        cell.contentView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        cell.contentView.layer.borderWidth = 0.5

//
//        let border = CALayer()
//        let width = CGFloat(2.0)
//        border.borderColor = UIColor.darkGray.cgColor
//        border.frame = CGRect(x: 0, y: cell.contentView.frame.size.height - width, width:  cell.contentView.frame.size.width, height: cell.contentView.frame.size.height)
//
//        border.borderWidth = width
//        cell.contentView.layer.addSublayer(border)
//        cell.contentView.layer.masksToBounds = true
        cell.contentView.clipsToBounds = true
        
        //collection view doesnt have a row, it has an item
        let movie = movies[indexPath.item]
        //configue the cell -- as in movies view controller with the table view-- this case is a grid view
        //Adding the poster image
        // this builds the url and gets the image with alamofireImage
        //According to the API configuration , you need baseURL, fileSize, and filePath
        let baseURL: String = "https://image.tmdb.org/t/p/"
        //this size is specified on the API, they have different sizes available
        let fileSize: String = "w1280"
        let posterImagePath: String = movie["poster_path"] as! String
        
        
        //the URL datatype is like a string but it validates the http, semicolons, etc.
        let posterURL = URL(string: baseURL + fileSize + posterImagePath)
        // after installing alamofireImage library
        
        cell.posterView.af_setImage(withURL: posterURL!)
        return cell
    }
    

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Find the selected mvoie
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let movie = movies[indexPath.item]
        
        //print(movie["title"])
        // Pass the selected object to the new view controller.
        //pass the selected movie to details
        let detailsViewController = segue.destination as! GridDetailsViewController
        detailsViewController.movie = movie
        
        //print("loading details screen")
        
    }


}
