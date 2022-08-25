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
    
    let ColorC = UIColor(named: "Color-c")
    let ColorB = UIColor(named: "Color-b")
    let ColorA = UIColor(named: "Color-a")
    
    var takeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ShowPetDetailDetailListCell")
        tableView.register(DelPetButtonCell.self, forCellReuseIdentifier: "DelPetButtonCell")
        tableView.rowHeight = UITableView.automaticDimension
        
        let headerView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 300))
        let imageURL = URL(string: "https://www.daejeon.go.kr/\(pets!.filePath)")
        headerView.contentMode = .scaleAspectFit
        headerView.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "DognotFound"))
        
        tableView.tableHeaderView = headerView
        
    }
}
//UITableView DataSource, Delegate
extension ShowPetDetailViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 11
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
            return "foundPlace"
        case 3:
            return "gender"
        case 4:
            return "gu"
        case 5:
            return "hairColor"
        case 6:
            return "memo"
        case 7:
            return "rescueDate"
        case 8:
            return "species"
        case 9:
            return "weight"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ShowPetDetailListCell2")
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "\(pets!.adoptionStatusCd)"
            return cell
        case 1:
            cell.textLabel?.text = pets!.age
            return cell
        case 2:
            cell.textLabel?.text = "\(pets!.foundPlace)"
            return cell
        case 3:
            if(pets!.gender == 1) {
                cell.textLabel?.text = "수컷"
            } else {
                cell.textLabel?.text = "암컷"
            }
            return cell
        case 4:
            if(pets!.gu == 1){
                cell.textLabel?.text = "동구"
            } else if(pets!.gu == 2) {
                cell.textLabel?.text = "중구"
            }else if(pets!.gu == 3) {
                cell.textLabel?.text = "서구"
            }else if(pets!.gu == 4) {
                cell.textLabel?.text = "유성구"
            } else {
                cell.textLabel?.text = "대덕구"
            }

            return cell
        case 5:
            cell.textLabel?.text = "\(pets!.hairColor)"
            return cell
        case 6:
            cell.textLabel?.text = "\(pets!.memo)"
            return cell
        case 7:
            cell.textLabel?.text = "\(pets!.rescueDate)"
            return cell
        case 8:
            cell.textLabel?.text = "\(pets!.species)"
            return cell
        case 9:
            cell.textLabel?.text = "\(pets!.weight)"
            return cell
        case 10:
            let cell3 = tableView.dequeueReusableCell(withIdentifier: DelPetButtonCell.id, for: indexPath) as! DelPetButtonCell
            cell3.textLabel?.text = "                                찜하기 취소"
            cell3.backgroundColor = ColorB
            cell3.tintColor = .white
            return cell3
        default:
            cell.textLabel?.text = "🍎"
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 10) {
            print("삭제함 ㅅㄱ")
            deletePet()
        }
    }
    
    
    func deletePet() {
            let AT : String? = KeyChain.read(key: Token.accessToken)
            let RT : String? = KeyChain.read(key: Token.refreshToken)
        let url = "http://10.156.147.167:8080/api/pet/deleteMyPet?id=\(pets!.id)"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.timeoutInterval = 10
            var header = HTTPHeaders()
            header.add(name: "Authorization", value: "Bearer \(AT!)")
            header.add(name: "X-Refresh-Token", value: RT!)
            

        AF.request(url,method: .delete, encoding: JSONEncoding.default, headers: header)
            .responseString { (response) in
                switch response.response?.statusCode {
                case 200:
                    debugPrint(response)
                    print("url 경로 : \(request.url as Any)")
                    print("✅POST 성공✅")

                    let AlertMassge = UIAlertController(title: "알림", message: "취소 성공", preferredStyle: UIAlertController.Style.alert)
                    let ActionMassge = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    
                    AlertMassge.addAction(ActionMassge)
                    self.present(AlertMassge, animated: true, completion: nil)
                default:
                    print("🤯post 성공하지 못했습니다🤬")
                    debugPrint(response)
            }
        }
    }
}
