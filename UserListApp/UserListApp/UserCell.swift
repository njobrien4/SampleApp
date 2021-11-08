//
//  UserCell.swift
//  UserListApp
//
//  Created by Nicole O'Brien on 11/6/21.
//

import Foundation
import UIKit

final class UserCell: UITableViewCell {
    
    private let userView = BaseUserView(frame: CGRect.zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.userView)
        let constraints = [self.trailingAnchor.constraint(equalTo: self.userView.trailingAnchor), self.leadingAnchor.constraint(equalTo: self.userView.leadingAnchor), self.topAnchor.constraint(equalTo: self.userView.topAnchor), self.bottomAnchor.constraint(equalTo: self.userView.bottomAnchor)]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
    }
    
    func configure(name: String, score: Int, image: String, badgeCounts: BadgeCount) {
        self.userView.configure(name: name, score: score, image: image, badgeCounts: badgeCounts)
    }
    
}
