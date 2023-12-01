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

protocol AnyUserDetailView {
    var presenter: AnyUserDetailPresenter? { get set }
    func showUser(_ user: User)
}

class UserDetailViewController: UIViewController, AnyUserDetailView{
    var presenter: AnyUserDetailPresenter?
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(label)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
    }
    
    func showUser(_ user: User) {
        label.text = user.name
    }
}

