//
//  Model.swift
//  Youngest
//
//  Created by Nathan Broyles on 12/8/19.
//  Copyright © 2019 DeadPixel. All rights reserved.
//

import Foundation

class Model {
    
    typealias json = [String: Any]
    
    static let shared = Model()
    private let listEndpoint = "https://appsheettest1.azurewebsites.net/sample/list?token="
    private let detailEndpoint = "http://appsheettest1.azurewebsites.net/sample/detail/"
    var users: [User]? = nil
    
    func youngestUsers(_ count: Int) -> [User]? {
        guard let youngestUsers = users?.sorted(by: {
            return $0.age < $1.age
        }) else {
            return nil
        }
        return Array(youngestUsers[0..<count])
    }
    
    func loadUsers(completion: @escaping ([User]?) -> Void) {
        var userIds: [Int] = [Int]()
        
        func fetchIds(withToken token: String = "") {
            guard let listURL = URL(string: "\(listEndpoint)\(token)") else {
                completion(nil)
                return
            }
            URLSession.shared.dataTask(with: listURL) { (data, response, error) in
                guard let jsonData = data,
                    let json = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? json else {
                        completion(nil)
                    return
                }
                
                if let ids = json["result"] as? [Int] {
                    userIds.append(contentsOf: ids)
                }
                
                if let token = json["token"] as? String {
                    fetchIds(withToken: token)
                } else {
                    self.fetchUsers(with: userIds, completion: completion)
                }
            }.resume()
        }
        
        fetchIds()
    }
    
    private func fetchUsers(with ids: [Int], completion: @escaping ([User]?) -> Void) {
        let downloadGroup = DispatchGroup()
        var users: [User] = [User]()
        
        for id in ids {
            downloadGroup.enter()
            
            guard let detailURL = URL(string: "\(detailEndpoint)\(id)") else {
                completion(nil)
                return
            }
            URLSession.shared.dataTask(with: detailURL) { (data, response, error) in
                guard let jsonData = data else {
                    completion(nil)
                    return
                }

                if let user = try? JSONDecoder().decode(User.self, from: jsonData), user.isValid() {
                    users.append(user)
                }
                
                downloadGroup.leave()
            }.resume()
        }
        
        downloadGroup.notify(queue: DispatchQueue.main) {
            self.users = users
            completion(users)
        }
    }
}

struct User: Codable {
    
    let id: Int
    let name: String
    let age: Int
    let number: String
    let photo: String
    let bio: String
    
    func isValid() -> Bool {
        let regex = try? NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        let cleanNumber = regex?.stringByReplacingMatches(in: number, options: [], range: NSRange(location: 0, length: number.count), withTemplate: "")
        if cleanNumber?.count == 10 {
            return true
        } else {
            return false
        }
    }
}
