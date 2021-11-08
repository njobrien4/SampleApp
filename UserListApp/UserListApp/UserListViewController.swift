//
//  ViewController.swift
//  UserListApp
//
//  Created by Nicole O'Brien on 11/6/21.
//

import UIKit

protocol UserListViewProtocol: UIViewController {
    
    var presenter: UserListPresenterProtocol { get }
    
    func refreshList()
    
}

final class UserListViewController: UITableViewController, UserListViewProtocol {
    
    @IBOutlet var userTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "User List"
        self.userTableView.register(UserCell.self, forCellReuseIdentifier: "UserCell")
        self.userTableView.estimatedRowHeight = UITableView.automaticDimension
        self.presenter.fetchUserList()
    }
    
    private lazy var internalPresenter: UserListPresenter = {
            return UserListPresenter(view: self)
        }()
    
    var presenter: UserListPresenterProtocol {
            return self.internalPresenter
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.userTableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell else { return UITableViewCell() }
        guard !self.presenter.viewModels.isEmpty else { return UITableViewCell() }
        let viewModel = self.presenter.viewModels[indexPath.row]
        cell.configure(name: viewModel.displayName, score: viewModel.reputation, image: viewModel.profileImage, badgeCounts: viewModel.badgeCounts)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = self.presenter.viewModels[indexPath.row]
        let userDetailsViewController = UserDetailsViewController()
        userDetailsViewController.presenter.refreshUser(user)
        userDetailsViewController.navigationItem.title = user.displayName
        self.navigationController?.pushViewController(userDetailsViewController, animated: true)
    }
    
    func refreshList() {
        DispatchQueue.main.async {
            self.userTableView.reloadData()
        }
    }

}
