//
//  ViewController.swift
//  Youngest
//
//  Created by Nathan Broyles on 12/8/19.
//  Copyright © 2019 DeadPixel. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    var users: [User]? = nil {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Model.shared.loadUsers { (users) in
            self.users = Model.shared.youngestUsers(5)
        }
    }
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let user = users?[indexPath.row]
        cell.textLabel?.text = user?.name.uppercased()
        cell.detailTextLabel?.text = "id: \(user?.id ?? 0)\nage: \(user?.age ?? 0)\n\(user?.number ?? "")"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return (users?.count ?? 0) == 0 ? 250 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if (users?.count ?? 0) == 0 {
            let view = UIActivityIndicatorView(style: .large)
            view.startAnimating()
            return view
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
