//
//  UIImageView+Extensions.swift
//  UserListApp
//
//  Created by Nicole O'Brien on 11/6/21.
//

import UIKit

extension UIImageView {

    public func imageFromServerURL(urlString: String) {
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
         if error != nil {
             print(error ?? "No Error")
             return
         }
         DispatchQueue.main.async(execute: { () -> Void in
             let image = UIImage(data: data!)
             self.image = image
         })
     }).resume()
    }
    
}
