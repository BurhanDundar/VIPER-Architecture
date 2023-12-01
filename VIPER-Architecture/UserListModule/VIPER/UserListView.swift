//
//  View.swift
//  VIPER-Architecture
//
//  Created by Yapı Kredi Teknoloji A.Ş. on 1.12.2023.
//

import Foundation
import UIKit

// ViewController
// Protocol
// Reference presenter

protocol AnyUserListView {
    var presenter: AnyUserListPresenter? { get set }
    
    func update(with users: [User])
    func update(with error: String)
}

class UserListViewController: UIViewController, AnyUserListView, UITableViewDelegate, UITableViewDataSource {
    var presenter: AnyUserListPresenter?
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        view.addSubview(label)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
    }
    
    func update(with users: [User]) {
        DispatchQueue.main.async {
            self.users = users
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.users = []
            self.label.text = error
            self.tableView.isHidden = true
            self.label.isHidden = false
        }
        
    }
    
    // Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = self.users[indexPath.row]
        presenter?.showUserDetail(user)
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let user = self.users[indexPath.row]
//        presenter?.showTodoDetail(todo)
//    }
}
