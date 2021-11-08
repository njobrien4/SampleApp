//
//  UserDetailsPresenter.swift
//  UserListApp
//
//  Created by Nicole O'Brien on 11/8/21.
//

import Foundation

protocol UserDetailsPresenterProtocol {
    
    var viewModel: User? { get }
    var rows: [UserDetailRow] { get }
    
    func refreshUser(_ user: User)
    
}

struct UserDetailRow {
    
    var title: String
    var detail: String
    
}

final class UserDetailsPresenter: UserDetailsPresenterProtocol {

    private weak var view: UserDetailsViewProtocol?
    
    var viewModel: User?
    
    var rows: [UserDetailRow] = []
    
    init(view: UserDetailsViewProtocol?) {
        self.view = view
    }
    
    func refreshUser(_ user: User) {
        self.viewModel = user
        self.rows = [UserDetailRow(title: "website", detail: user.websiteUrl), UserDetailRow(title: "link", detail: user.link)]
        self.view?.refreshList()
    }
    
}
