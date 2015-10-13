//
//  ViewController.swift
//  Class5.2
//
//  Created by Elaine Fang on 10/7/15.
//  Copyright © 2015 Elaine Fang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!

    @IBOutlet weak var button: UIButton!
    
    var movieNames = [String]()
    var moviePosters = [String]()
    var movieImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let movieController = segue.destinationViewController as? MyTableViewController {
            movieController.movieNames = movieNames
            movieController.moviePosters = moviePosters
            movieController.movieImages = movieImages
        }
    }
    
    @IBAction func dumbButton() {
        
        let searchString = textField.text!
        
        let escapedString = searchString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
        
        // Step 1: make URL string
        let urlString = "http://www.omdbapi.com/?s=\(escapedString)"
        
        // Step 2: make an URL
        if let url = NSURL(string: urlString) {
            
            // Step 3: make an URL request from the URL
            let request = NSURLRequest(URL: url)
            
            // Step 4: use the session to create a data task
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if let data = data {
                        let json = try! NSJSONSerialization.JSONObjectWithData(data, options: [])
//                        print(json)
                        
                        
                        if let jsonDict = json as? NSDictionary, movies = jsonDict["Search"] as? NSArray {
                            
                            
                            
                            for movie in movies {
                                if let title = movie["Title"] as? String {
                                    self.movieNames.append(title)
//                                    print(title)
                                }
                                if let poster = movie["Poster"] as? String {
                                    self.moviePosters.append(poster)
//                                    print(poster)
                                    
                                    
                                    let url = NSURL(string: poster)
                                    let data = NSData(contentsOfURL: url!)
                                    if data != nil {
                                        self.movieImages.append(UIImage(data:data!)!)
                                    }
                                }
                            }
                            
                        }
                        
                    }
//                    print("RESPONDED!")
                })
                
            })
            
            // Step 5: call the request!
            task.resume()
            

        }
        
    }
    
    @IBAction func moveButton() {
        
        UIView.animateWithDuration(1.0) { () -> Void in
            self.button.frame = CGRectMake(self.button.frame.origin.x, self.button.frame.origin.y + 10, self.button.frame.size.width, self.button.frame.size.height)
        }
//        
//        dispatch_async(dispatch_queue_create("background", nil)) { () -> Void in
//            for i in 1...100000000 {
//                print(i)
//            }
//        }
        
//        dispatch_async(dispatch_get_main_queue()) { () -> Void in
//            print("world")
//        }
//        print("hello")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

