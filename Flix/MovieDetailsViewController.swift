//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Jorge Garcia on 9/28/20.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    // The movie dictionary with string key
    var movie: [String:Any]!
    
    //outlets for image views and label views
    
    @IBOutlet weak var backDropView: UIImageView!
    
    @IBOutlet weak var gradientView: UIImageView!
    
    @IBOutlet weak var posterView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var synopsisLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(movie["title"])
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        
    }


}
