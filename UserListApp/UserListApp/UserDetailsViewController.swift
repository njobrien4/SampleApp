//
//  UserDetailsViewController.swift
//  UserListApp
//
//  Created by Nicole O'Brien on 11/8/21.
//

import Foundation
import UIKit

protocol UserDetailsViewProtocol: UIViewController {
    
    var presenter: UserDetailsPresenterProtocol { get }
    
    func refreshList()
    
}

final class UserDetailsViewController: UITableViewController, UserDetailsViewProtocol {
 
    var userView: BaseUserView = BaseUserView(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(DefaultValue1TableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.tableHeaderView = userView
    }
    
    private lazy var internalPresenter: UserDetailsPresenter = {
            return UserDetailsPresenter(view: self)
        }()
    
    var presenter: UserDetailsPresenterProtocol {
            return self.internalPresenter
        }
    
    func refreshList() {
        guard let user = self.presenter.viewModel else { return }
        self.userView.configure(name: user.displayName, score: user.reputation, image: user.profileImage, badgeCounts: user.badgeCounts, location: user.location)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DefaultValue1TableViewCell else { return UITableViewCell() }
        let row = self.presenter.rows[indexPath.row]
        cell.textLabel?.text = row.title
        cell.detailTextLabel?.text = row.detail
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = self.presenter.rows[indexPath.row].detail
        self.openUrl(urlString: url)
    }
    
    private func openUrl(urlString:String!) {
        let url = URL(string: urlString)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
}

final class DefaultValue1TableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
