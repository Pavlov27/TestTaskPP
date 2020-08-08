//
//  CustomUI.swift
//  Test1
//
//  Created by Nikita Pavlov on 08.08.2020.
//  Copyright © 2020 Nikita Pavlov. All rights reserved.
//

import UIKit

struct Colors {
    static let navBarColor = UIColor(displayP3Red: 85/255, green: 163/255, blue: 207/255, alpha: 1)
    static let darkCellColor = UIColor(displayP3Red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
    static let lightCellColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
}

class CustomCell: UICollectionViewCell {

    let cellLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Thonburi", size: 21.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        contentView.addSubview(cellLabel)
        cellLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        cellLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        //hide or reset anything you want hereafter, for example
        self.backgroundColor = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
