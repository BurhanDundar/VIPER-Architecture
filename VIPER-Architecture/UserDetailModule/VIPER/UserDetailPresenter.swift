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


protocol AnyUserDetailPresenter {
    var router: AnyUserDetailRouter? { get set }
    var interactor: AnyUserDetailInteractor? { get set }
    var view: AnyUserDetailView? { get set }
    
    func viewDidLoad()
}

class UserDetailPresenter: AnyUserDetailPresenter {
    var router: AnyUserDetailRouter?
    var interactor: AnyUserDetailInteractor?
    var view: AnyUserDetailView?
    
    func viewDidLoad() {
        if let user = interactor?.user {
            view?.showUser(user)
        }
    }
}

