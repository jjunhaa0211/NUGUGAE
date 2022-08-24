//
//  DelPetButtonCell.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/08/24.
//

import Foundation
import UIKit

class DelPetButtonCell: UITableViewCell {
    static let id = "DelPetButtonCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("DelPetButtonCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let customButton: UIButton = {
        let a = UIButton(type: .custom)
        a.setTitle("asdf", for: .normal)
        a.titleLabel?.text = "asdfghjkl"
        return a
    }()
}
