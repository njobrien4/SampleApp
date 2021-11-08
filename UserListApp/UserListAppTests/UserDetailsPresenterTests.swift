//
//  UserDetailsPresentreTests.swift
//  UserListAppTests
//
//  Created by Nicole O'Brien on 11/8/21.
//

import XCTest
@testable import UserListApp

class UserDetailsPresenterTests: XCTestCase {
    
    final class FakeUserDetailsViewController: UIViewController, UserDetailsViewProtocol {
        
        var didCallRefresh: Bool = false
        
        func refreshList() {
            self.didCallRefresh = true
        }
        
        var presenter: UserDetailsPresenterProtocol {
            return self.internalPresenter
        }
        
        private lazy var internalPresenter: UserDetailsPresenterProtocol  = {
            return UserDetailsPresenter(view: self)
        }()
        
        init() {
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }


    var configuration: URLSessionConfiguration = URLSessionConfiguration.ephemeral
    var presenter: UserDetailsPresenter!
    var fakeUserDetailsViewController: FakeUserDetailsViewController!
    
    override func setUpWithError() throws {
        self.fakeUserDetailsViewController = FakeUserDetailsViewController()
        self.presenter = UserDetailsPresenter(view: self.fakeUserDetailsViewController)
    }

    override func tearDownWithError() throws {
        self.presenter = nil
    }
    
    func testExample() throws {
        XCTAssertFalse(self.fakeUserDetailsViewController.didCallRefresh)
        self.presenter.refreshUser(User(displayName: "Nicole", profileImage: "https://www.image.com", reputation: 30, badgeCounts: BadgeCount(gold: 1, silver: 2, bronze: 3), location: nil, websiteUrl: "https://www.google.com", link: "https://www.google.com"))
        XCTAssertNil(self.presenter.viewModel?.location)
        XCTAssertEqual(self.presenter.viewModel?.displayName, "Nicole")
        XCTAssertTrue(self.fakeUserDetailsViewController.didCallRefresh)
    }

}


