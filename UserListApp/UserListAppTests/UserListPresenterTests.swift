//
//  UserListAppTests.swift
//  UserListAppTests
//
//  Created by Nicole O'Brien on 11/6/21.
//

import XCTest
@testable import UserListApp

class UserListPresenterTests: XCTestCase, RequestManagerTestingProtocol {

    var configuration: URLSessionConfiguration = URLSessionConfiguration.ephemeral
    var presenter: UserListPresenter!
    
    override func setUpWithError() throws {
        self.configuration.protocolClasses = [MockURLProtocol.self]
        self.presenter = UserListPresenter(view: nil, urlConfiguration: self.configuration)
    }

    override func tearDownWithError() throws {
        self.presenter = nil
    }

    func testUserListPresenter() throws {
        XCTAssertEqual(self.presenter.viewModels.count, 0)
        self.presenter.fetchUserList()
        self.setUpRequestHandler(statusCode: 200, data: UserListPresenterTests.jsonResponse)
        let expectationPass = XCTestExpectation(description: "Fetch success")
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
            XCTAssertEqual(self.presenter.viewModels.count, 4)
            expectationPass.fulfill()
        }
    }
    
    func testUserListModel() throws {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let model = UserListModel(configuration: configuration)
        self.setUpRequestHandler(statusCode: 200, data: UserListPresenterTests.jsonResponse)
        let expectationPass = XCTestExpectation(description: "Model Success")
        model.fetchUserList() { (users, error) in
            XCTAssertNil(error)
             XCTAssertEqual(model.users.count, 4)
            expectationPass.fulfill()
        }

        wait(for: [expectationPass], timeout: 1)
        
    }
    
    static let jsonResponse = """
        {   "items":[{"badge_counts":{"bronze":8989,"silver":8817,"gold":806},"account_id":11683,"is_employee":false,"last_modified_date":1635883800,"last_access_date":1636401217,"reputation_change_year":62845,"reputation_change_quarter":7548,"reputation_change_month":1585,"reputation_change_week":400,"reputation_change_day":200,"reputation":1294089,"creation_date":1222430705,"user_type":"registered","user_id":22656,"accept_rate":86,"location":"Reading, United Kingdom","website_url":"http://csharpindepth.com","link":"https://stackoverflow.com/users/22656/jon-skeet","profile_image":"https://www.gravatar.com/avatar/6d8ebb117e8d83d74ea95fbdd0f87e13?s=256&d=identicon&r=PG","display_name":"Jon Skeet"},{"badge_counts":{"bronze":654,"silver":516,"gold":51},"account_id":1165580,"is_employee":false,"last_modified_date":1635772800,"last_access_date":1632610900,"reputation_change_year":118220,"reputation_change_quarter":4817,"reputation_change_month":945,"reputation_change_week":155,"reputation_change_day":70,"reputation":1173936,"creation_date":1326311637,"user_type":"registered","user_id":1144035,"location":"New York, United States","website_url":"http://www.data-miners.com","link":"https://stackoverflow.com/users/1144035/gordon-linoff","profile_image":"https://www.gravatar.com/avatar/e514b017977ebf742a418cac697d8996?s=256&d=identicon&r=PG","display_name":"Gordon Linoff"},{"badge_counts":{"bronze":4486,"silver":3812,"gold":456},"account_id":4243,"is_employee":false,"last_modified_date":1636300202,"last_access_date":1636400998,"reputation_change_year":71994,"reputation_change_quarter":8842,"reputation_change_month":2038,"reputation_change_week":550,"reputation_change_day":305,"reputation":1080690,"creation_date":1221344553,"user_type":"registered","user_id":6309,"accept_rate":100,"location":"France","website_url":"http://careers.stackoverflow.com/vonc","link":"https://stackoverflow.com/users/6309/vonc","profile_image":"https://i.stack.imgur.com/I4fiW.jpg?s=256&g=1","display_name":"VonC"},{"badge_counts":{"bronze":3481,"silver":3514,"gold":357},"account_id":52822,"is_employee":false,"last_modified_date":1636389900,"last_access_date":1636392798,"reputation_change_year":46452,"reputation_change_quarter":4884,"reputation_change_month":979,"reputation_change_week":170,"reputation_change_day":100,"reputation":1015571,"creation_date":1250527322,"user_type":"registered","user_id":157882,"accept_rate":93,"location":"Willemstad, Cura&#231;ao","website_url":"https://balusc.omnifaces.org","link":"https://stackoverflow.com/users/157882/balusc","profile_image":"https://www.gravatar.com/avatar/89927e2f4bde24991649b353a37678b9?s=256&d=identicon&r=PG","display_name":"BalusC"}
        ]}
        """.data(using: .utf8)!

}
