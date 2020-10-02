//
//  GridDetailsViewController.swift
//  Flix
//
//  Created by Jorge Garcia on 10/2/20.
//

import UIKit
import AlamofireImage

class GridDetailsViewController: UIViewController {

    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var gradientView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie: [String:Any]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //All this code is copy-paste from MovieDetailsViewController
        
        //print(movie["title"])
        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["overview"] as? String
        //------------------------------------------
        // this is the same URL builder from MovieViewController
        //This is used for posterView
        let baseURL: String = "https://image.tmdb.org/t/p/"
        //this size is specified on the API, they have different sizes available
        let posterSize: String = "w500"
        let posterImagePath: String = movie["poster_path"] as! String
        //the URL datatype is like a string but it validates the http, semicolons, etc.
        let posterURL = URL(string: baseURL + posterSize + posterImagePath)
        // after importing alamofireImage library
        posterView.af_setImage(withURL: posterURL!)
        //------------------------------------------
        //backdropview
        let backDropSize: String = "w1280"
        let backDropImagePath: String = movie["backdrop_path"] as! String
        let backDropPathURL = URL(string: baseURL + backDropSize + backDropImagePath)
        backdropView.af_setImage(withURL: backDropPathURL!)
        
        //tweaking poster frame
        posterView.layer.borderWidth = 1
        posterView.layer.masksToBounds = false
        posterView.layer.borderColor = UIColor.darkGray.cgColor
        posterView.clipsToBounds = true
        posterView.layer.cornerRadius = 5
        
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }


}
