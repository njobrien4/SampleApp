//
//  MockURLProtocol.swift
//  UserListAppTests
//
//  Created by Nicole O'Brien on 11/8/21.
//

import Foundation
import XCTest

class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse?, Data?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            return
        }
        
        do {
            let (response, data) = try handler(request)
            if let response = response {
                self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let data = data {
                self.client?.urlProtocol(self, didLoad: data)
            }
            self.client?.urlProtocolDidFinishLoading(self)
        } catch {
            self.client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {}
    
}

protocol RequestManagerTestingProtocol {
    
    func setUpRequestHandler(statusCode: Int, data: Data?, headerFields: [String: String]?)
    
}

extension RequestManagerTestingProtocol where Self: XCTestCase {
    
    func setUpRequestHandler(statusCode: Int, data: Data? = nil, headerFields: [String: String]? = nil) {
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url, let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: headerFields) else { return (nil, nil) }
            return (response, data)
        }
    }
    
}
