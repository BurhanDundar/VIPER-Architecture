//
//  Router.swift
//  VIPER-Architecture
//
//  Created by Yapı Kredi Teknoloji A.Ş. on 1.12.2023.
//

import Foundation
import UIKit

// Object
// Entry point

typealias EntryPoint = AnyUserListView & UIViewController

protocol AnyUserListRouter {
    var entry: EntryPoint? { get }
    
    static func start() -> AnyUserListRouter
    func presentUserDetailScreen(from view: AnyUserListView, for todo: User)
}

class UserListRouter: AnyUserListRouter {
    var entry: EntryPoint?
    
    static func start() -> AnyUserListRouter {
        let router = UserListRouter()
        
        // Assign VIP
        var view: AnyUserListView = UserListViewController()
        var presenter: AnyUserListPresenter = UserListPresenter()
        var interactor: AnyUserListInteractor = UserListInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        // interactor.getUsers()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
    
    func presentUserDetailScreen(from view: AnyUserListView, for user: User) {
        
        let userDetailRouter = UserDetailRouter.createTodoDetailRouterModule(with: user)
        
        let initialVC = userDetailRouter.entry as! UIViewController
        
        
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid View Protocol type")
        }

//        viewVC.navigationController?.pushViewController(initialVC, animated: true)
//
//        viewVC.navigationController?.setViewControllers([initialVC], animated: true)
        
//        viewVC.window?.rootViewController = UINavigationController(rootViewController: initialVC)
        viewVC.present(initialVC, animated: true)
        
//        viewVC.view.window?.rootViewController = UINavigationController(rootViewController: initialVC)
//        viewVC.navigationController?.pushViewController(initialVC, animated: true)

    }
    
}
