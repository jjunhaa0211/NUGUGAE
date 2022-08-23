//
//  ShowButtonVC.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/08/23.
//

import UIKit

// 범용성을 위해 class가 아닌 AnyObject로 선언해준다.
protocol ContentsMainTextDelegate: AnyObject {
    // 위임해줄 기능
    func categoryButtonTapped()
}

class Contents_MainTextCell: UITableViewCell {
    
    var cellDelegate: ContentsMainTextDelegate?

    
    let ColorC = UIColor(named: "Color-c")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 여기서 버튼에 액션 추가
        self.categoryButton.addTarget(self, action: #selector(categoryClicked), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 버튼
    let categoryButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("기타 중고물품", for: .normal)
//        bt.setTitleColor(UIColor(named: ), for: .normal)
        bt.titleLabel?.font = UIFont(name: "Helvetica", size: 12)
        bt.addTarget(Contents_MainTextCell.self, action: #selector(categoryClicked), for: .touchUpInside)
        return bt
    }()
    
    
    // 위임해줄 기능을 미리 구현해두어 버튼에 액션 추가
    @objc func categoryClicked() {
        cellDelegate?.categoryButtonTapped()
        print("안녕")
    }

}
