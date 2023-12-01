//
//  Interactor.swift
//  VIPER-Architecture
//
//  Created by Yapı Kredi Teknoloji A.Ş. on 1.12.2023.
//

import Foundation

// Object
// Protocol
// Reference to presenter

protocol AnyUserDetailInteractor {
    var presenter: AnyUserDetailPresenter? { get set }
    
    var user: User? { get set }
}

class UserDetailInteractor: AnyUserDetailInteractor {
    
    var presenter: AnyUserDetailPresenter?
    var user: User?
}

