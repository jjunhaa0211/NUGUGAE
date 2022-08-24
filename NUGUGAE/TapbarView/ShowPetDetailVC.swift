//
//  SavePetDetailVC.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/08/23.
//

import UIKit
import Alamofire

class ShowPetDetailViewController: UITableViewController {
    
    var pets: Pet?
    
    var takeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "petDetailListCell")
        tableView.rowHeight = UITableView.automaticDimension
        
        let headerView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 300))
        let imageURL = URL(string: "https://www.daejeon.go.kr/\(pets!.filePath)")
        headerView.contentMode = .scaleAspectFit
        headerView.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "DognotFound"))
        
        tableView.tableHeaderView = headerView
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    

}
//UITableView DataSource, Delegate
extension ShowPetDetailViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 12
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "adoptionStatusCd"
        case 1:
            return "age"
        case 2:
            return "classification"
        case 3:
            return "foundPlace"
        case 4:
            return "gender"
        case 5:
            return "gu"
        case 6:
            return "hairColor"
        case 7:
            return "memo"
        case 8:
            return "rescueDate"
        case 9:
            return "species"
        case 10:
            return "weight"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "petDetailListCell")
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "\(pets!.adoptionStatusCD)"
            return cell
        case 1:
            cell.textLabel?.text = pets!.age
            return cell
        case 2:
            cell.textLabel?.text = "\(pets!.classification)"
            return cell
        case 3:
            cell.textLabel?.text = "\(pets!.foundPlace)"
            return cell
        case 4:
            cell.textLabel?.text = "\(pets!.gender)"
            return cell
        case 5:
            cell.textLabel?.text = "\(pets!.gu)"
            return cell
        case 6:
            cell.textLabel?.text = "\(pets!.hairColor)"
            return cell
        case 7:
            cell.textLabel?.text = "\(pets!.memo)"
            return cell
        case 8:
            cell.textLabel?.text = "\(pets!.rescueDate)"
            return cell
        case 9:
            cell.textLabel?.text = "\(pets!.species)"
            return cell
        case 10:
            cell.textLabel?.text = "\(pets!.weight)"
            return cell
        case 11:
//            cell.
            return cell
        default:
            cell.textLabel?.text = "🍎"
            return cell
        }
    }
    @objc func loginbuttonAction(sender: UIButton!){
        print(" 로그인 버튼 실행됨")
    }
}
