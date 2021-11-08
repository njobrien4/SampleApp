//
//  UserListPresenter.swift
//  UserListApp
//
//  Created by Nicole O'Brien on 11/6/21.
//

import Foundation

protocol UserListPresenterProtocol {
    
    var viewModels: [User] { get }
    func fetchUserList()
}

final class UserListPresenter: UserListPresenterProtocol {
    
    init(view: UserListViewProtocol?, urlConfiguration: URLSessionConfiguration = .ephemeral) {
        self.view = view
        self.model = UserListModel(configuration: urlConfiguration)
    }
    
    private weak var view: UserListViewProtocol?
    let model: UserListModel
    var viewModels: [User] = []
    
    func fetchUserList() {
        self.model.fetchUserList { [weak self] (users, error) in
            guard error == nil else { return }
            self?.viewModels = users
            self?.view?.refreshList()
        }
    }
    
}


