//
//  Presenter.swift
//  VIPER-Architecture
//
//  Created by Yapı Kredi Teknoloji A.Ş. on 1.12.2023.
//

import Foundation

// Object
// Protocol
// Reference to interactor, router, view

enum FetchError: Error {
    case failed
}


protocol AnyUserListPresenter {
    var router: AnyUserListRouter? { get set }
    var interactor: AnyUserListInteractor? { get set }
    var view: AnyUserListView? { get set }
    
    func interactorDidFetchUserResults(with result: Result<[User],Error>)
    func showUserDetail(_ user: User)
}

class UserListPresenter: AnyUserListPresenter {
    var router: AnyUserListRouter?
    var interactor: AnyUserListInteractor? {
        didSet {
                interactor?.getUsers()
        }
    }
    var view: AnyUserListView?
    
//    init() {
//        interactor?.getUsers()
//    }
    
    func interactorDidFetchUserResults(with result: Result<[User],Error>) {
        switch result {
            case .success(let users):
                view?.update(with: users)
            case .failure:
                view?.update(with: "Something went wrong")
        }
    }
    
    func showUserDetail(_ user: User) {
        guard let view = view else { return }
        router?.presentUserDetailScreen(from: view, for: user)
    }

}
