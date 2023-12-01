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


protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func interactorDidFetchUserResults(with result: Result<[User],Error>)
}

class UserPresenter: AnyPresenter {
    var router: AnyRouter?
    var interactor: AnyInteractor? {
        didSet {
                interactor?.getUsers()
        }
    }
    var view: AnyView?
    
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
}
