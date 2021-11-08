//
//  File.swift
//  UserListApp
//
//  Created by Nicole O'Brien on 11/6/21.
//

import Foundation
import UIKit

enum BadgeType {
    case gold
    case silver
    case bronze
}

final class BadgeView: UIStackView {
    
    private struct Constant {
        static let badgeDiameter = 10.0
        static let spacing = 5.0
    }
    
    private let circleView: UIView = {
        let circleView = UIView(frame: CGRect.zero)
        circleView.translatesAutoresizingMaskIntoConstraints = false
        
        circleView.clipsToBounds = true
        circleView.layer.cornerRadius = Constant.badgeDiameter
        return circleView
    }()
    
    let pointsLabel: UILabel = {
        let otherLabel = UILabel()
        otherLabel.translatesAutoresizingMaskIntoConstraints = false
        return otherLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        self.spacing = Constant.spacing
        
        self.addArrangedSubview(self.circleView)
        self.addArrangedSubview(self.pointsLabel)
        let circleViewConstraints = [circleView.heightAnchor.constraint(equalToConstant: Constant.badgeDiameter), circleView.widthAnchor.constraint(equalTo: circleView.heightAnchor)]
        NSLayoutConstraint.activate(circleViewConstraints)
        
    }
    
    init(frame: CGRect, badgeType: BadgeType) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.spacing = Constant.spacing
        switch badgeType {
        case .gold:
            self.circleView.backgroundColor = .yellow
        case .silver:
            self.circleView.backgroundColor = .gray
        case .bronze:
            self.circleView.backgroundColor = .brown
        }
        self.addArrangedSubview(self.circleView)
        self.addArrangedSubview(self.pointsLabel)
        let circleViewConstraints = [circleView.heightAnchor.constraint(equalToConstant: Constant.badgeDiameter*2), circleView.widthAnchor.constraint(equalTo: circleView.heightAnchor)]
        NSLayoutConstraint.activate(circleViewConstraints)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPointsLabel(points: Int) {
        self.pointsLabel.text = String(points)
    }
    
}
