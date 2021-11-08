//
//  UserListModel.swift
//  UserListApp
//
//  Created by Nicole O'Brien on 11/6/21.
//

import Foundation
import UIKit


struct User: Decodable {
    
    let displayName: String
    let profileImage: String
    let reputation:  Int
    let badgeCounts: BadgeCount
    let location: String?
    let websiteUrl: String
    let link: String
    
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case profileImage = "profile_image"
        case reputation = "reputation"
        case badgeCounts = "badge_counts"
        case location = "location"
        case websiteUrl = "website_url"
        case link = "link"
    }
    
}

struct BadgeCount: Decodable {
    
    let gold: Int
    let silver: Int
    let bronze: Int
    
}

struct Response: Decodable {
    
    let items: [User]
    
}

class UserListModel {
    
    private(set) var users: [User] = []
    private let urlSession: URLSession
    
    init(configuration: URLSessionConfiguration = .default) {
        self.urlSession = URLSession(configuration: configuration)
    }
    
    func fetchUserList(completion: @escaping( (_ users: [User], _ error: Error?) -> Void )) {
        guard let url = URL(string: "https://api.stackexchange.com/2.2/users?site=stackoverflow") else {
            completion([], nil)
            return
        }
        
        let dataTask = self.urlSession.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let jsonArray = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let json = try JSONSerialization.data(withJSONObject: jsonArray, options: [])
                let response = try JSONDecoder().decode(Response.self, from: json)
                self.users = response.items
                completion(response.items, error)
            } catch let error {
                completion([], error)
            }
            
        }
        dataTask.resume()
    }
    
}
