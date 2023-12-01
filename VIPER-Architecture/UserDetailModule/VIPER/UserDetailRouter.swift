//
//  Router.swift
//  VIPER-Architecture
//
//  Created by Yapı Kredi Teknoloji A.Ş. on 1.12.2023.
//

import UIKit

typealias DetailEntryPoint = AnyUserDetailView & UIViewController

protocol AnyUserDetailRouter {
    var entry: DetailEntryPoint? { get }
    
    static func createTodoDetailRouterModule(with user: User) -> AnyUserDetailRouter/*UIViewController*/
    
    // PRESENTER -> ROUTER
    func navigateBackToListViewController(from view: AnyUserDetailRouter)
}

class UserDetailRouter: AnyUserDetailRouter {
    var entry: DetailEntryPoint?
    
    func navigateBackToListViewController(from view: AnyUserDetailRouter) {
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid view protocol type")
        }
        viewVC.navigationController?.popViewController(animated: true)
    }
    
    static func createTodoDetailRouterModule(with user: User) -> AnyUserDetailRouter /*UIViewController*/ {
//        let userDetailVC = UserDetailViewController()
//        var presenter: AnyUserDetailPresenter = UserDetailPresenter()
//        userDetailVC.presenter = presenter
//        presenter.view = userDetailVC
//        var interactor: AnyUserDetailInteractor = UserDetailInteractor()
//        interactor.presenter = presenter
//        presenter.interactor = interactor
//        let router: AnyUserDetailRouter = UserDetailRouter()
//        presenter.router = router
//
//        return userDetailVC
        
        let router = UserDetailRouter()
        
        // Assign VIP
        var view: AnyUserDetailView = UserDetailViewController()
        var presenter: AnyUserDetailPresenter = UserDetailPresenter()
        var interactor: AnyUserDetailInteractor = UserDetailInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        interactor.user = user
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? DetailEntryPoint
        
        return router
        
    }
}
