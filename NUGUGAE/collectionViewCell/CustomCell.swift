//
//  CustomCell.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/08/23.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {
    static let id = "CustomCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("1234567890")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let customButton: UIButton = {
        let b = UIButton(type: .custom)
        b.setTitle("asdf", for: .normal)
        b.titleLabel?.text = "asdfghjkl"
        return b
    }()
}
