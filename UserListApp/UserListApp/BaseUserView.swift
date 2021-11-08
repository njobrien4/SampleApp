//
//  File.swift
//  UserListApp
//
//  Created by Nicole O'Brien on 11/8/21.
//

import UIKit


final class BaseUserView: UIView {
    
    private struct Constant {
        static let nameFontSize: CGFloat = 16
        static let scoreFontSize: CGFloat = 16
        static let badgeSpacing: CGFloat = 10
        static let horizontalSpace: CGFloat = 15.0
        static let verticalSpace: CGFloat = 5.0
        static let preferredImageHeight: CGFloat = 40.0
    }
    
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: Constant.nameFontSize)
        lbl.textAlignment = .left
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        return lbl
    }()

    private let scoreLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: Constant.scoreFontSize)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .left
        return lbl
    }()

    private let userImage : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()

    private let goldBadge: BadgeView = BadgeView(frame: CGRect.zero, badgeType: .gold)
    private let silverBadge: BadgeView = BadgeView(frame: CGRect.zero, badgeType: .silver)
    private let bronzeBadge: BadgeView = BadgeView(frame: CGRect.zero, badgeType: .bronze)

    private let reputationBadgeStackView: UIStackView = {
        let reputationBadgeStackView = UIStackView()
        reputationBadgeStackView.translatesAutoresizingMaskIntoConstraints = false
        reputationBadgeStackView.axis = .horizontal
        reputationBadgeStackView.spacing = Constant.badgeSpacing
        reputationBadgeStackView.distribution = .fillProportionally
        return reputationBadgeStackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(userImage)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.reputationBadgeStackView.addArrangedSubview( self.scoreLabel)
        self.reputationBadgeStackView.addArrangedSubview( self.goldBadge)
        self.reputationBadgeStackView.addArrangedSubview( self.silverBadge)
        self.reputationBadgeStackView.addArrangedSubview( self.bronzeBadge)
        let stackView = UIStackView(arrangedSubviews: [self.nameLabel, reputationBadgeStackView])
        stackView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        
        let constraints = [
            self.userImage.topAnchor.constraint(equalTo: self.topAnchor, constant: Constant.verticalSpace),
            self.reputationBadgeStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            self.userImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constant.horizontalSpace),
            self.userImage.heightAnchor.constraint(equalToConstant: Constant.preferredImageHeight),
            self.userImage.widthAnchor.constraint(equalTo: self.userImage.heightAnchor),
            self.userImage.trailingAnchor.constraint(equalTo: stackView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(name: String, score: Int, image: String, badgeCounts: BadgeCount, location: String? = nil) {
        self.nameLabel.text = name
        if let location = location {
            self.nameLabel.text?.append(contentsOf: ", \(location)")
        }
        self.scoreLabel.text = String(score)
        self.goldBadge.setPointsLabel(points: badgeCounts.gold)
        self.silverBadge.setPointsLabel(points: badgeCounts.silver)
        self.bronzeBadge.setPointsLabel(points: badgeCounts.bronze)
        self.userImage.imageFromServerURL(urlString: image)
    }
        
}
