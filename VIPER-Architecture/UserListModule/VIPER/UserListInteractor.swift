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

// https://jsonplaceholder.typicode.com/users

protocol AnyUserListInteractor {
    var presenter: AnyUserListPresenter? { get set }
    
    func getUsers()
}

class UserListInteractor: AnyUserListInteractor {
    
    var presenter: AnyUserListPresenter?
    
    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { // neden ==
                self?.presenter?.interactorDidFetchUserResults(with: .failure(FetchError.failed))
                return
            }
                do {
                    let entities = try JSONDecoder().decode([User].self, from: data)
                    self?.presenter?.interactorDidFetchUserResults(with: .success(entities))
                } catch {
                    self?.presenter?.interactorDidFetchUserResults(with: .failure(error))
                }
        }
        
        task.resume()
        
    }
    
}
