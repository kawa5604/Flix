//
//  MoviesViewController.swift
//  Flix
//
//  Created by Jorge Garcia on 9/25/20.
//

import UIKit
import AlamofireImage


class MoviesViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        movies.count
        
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
//      stop using standard cell and change to reusable cell --> while not on screen, they dont waste memory
        // type cast it as MovieCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        //        get the movie titles
        let movie = movies[indexPath.row]
        //        This is from the API, this is how the column is called
        let title = movie["title"] as! String
        //this is not applicable anymore since the personalized cell has a label called TitleLabel
        //cell.textLabel!.text = "\(title)"
        cell.TitleLabel!.text = title
        // Same as with the title, you first declare a string variable that gets the overview column from the api
        //then assign its casted string value to the Synopsis Label we made in the moviecell class file
        let synopsis = movie["overview"] as! String
        cell.SynopsisLabel!.text = synopsis
        
        //Adding the poster image
        //According to the API configuration , you need baseURL, fileSize, and filePath
        let baseURL: String = "https://image.tmdb.org/t/p/"
        //this size is specified on the API, they have different sizes available
        let fileSize: String = "w185"
        let posterImagePath: String = movie["poster_path"] as! String
        
        
        //the URL datatype is like a string but it validates the http, semicolons, etc.
        let posterURL = URL(string: baseURL + fileSize + posterImagePath)
        // after installing alamofireImage library
        
        cell.PosterLabel.af_setImage(withURL: posterURL!)
        
        return cell
        
    }
    
//global variables in this scope are called properties
    
//    array of dictionaries for movies
    var movies = [[String:Any]]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //testing dark mode
        overrideUserInterfaceStyle = .dark
        //
        tableView.dataSource = self
        tableView.delegate = self
        
//        print("-------inside of movies view controller-------")
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            self.movies = dataDictionary["results"] as! [[String:Any]]
            self.tableView.reloadData()
//            print(dataDictionary)
              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data
            
           }
        }
        task.resume()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("------Loading Movie Details------")
        //Find the selected movie
        // Since the sender is of type Any? you need to cast it to a UI table view cell
        let cell = sender as! UITableViewCell
        //tableview then gets the actual index for the cell
        let indexPath = tableView.indexPath(for: cell)!
        //access the array
        let movie = movies[indexPath.row]
        
        //Pass the selected movie to the details view controller
        let detailsViewController = segue.destination as! MovieDetailsViewController
        detailsViewController.movie = movie
        
        
        //this deselects the row in the table view. When you return to the main movies view controller
        //the cell is now deselected
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }


}
