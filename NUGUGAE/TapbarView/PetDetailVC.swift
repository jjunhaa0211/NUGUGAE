//
//  PetDetailVC.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/08/22.
//

import UIKit
import Alamofire

class PetDetailViewController: UITableViewController {
    
    var pets: SearchPetList?
    
    let ColorC = UIColor(named: "Color-c")
    let ColorB = UIColor(named: "Color-b")
    let ColorA = UIColor(named: "Color-a")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "petDetailListCell")
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.rowHeight = UITableView.automaticDimension
        
        let headerView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 300))
        let imageURL = URL(string: "https://www.daejeon.go.kr/\(pets!.filePath)")
        headerView.contentMode = .scaleAspectFit
        headerView.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "DognotFound"))
        
        tableView.tableHeaderView = headerView
    }

}

//UITableView DataSource, Delegate
extension PetDetailViewController {
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
//            cell.textLabel?.text = "text click"
//            return cell
            let cell2 = tableView.dequeueReusableCell(withIdentifier: CustomCell.id, for: indexPath) as! CustomCell
            cell2.textLabel?.text = "                                  찜하기"
            cell2.backgroundColor = ColorB
            cell2.tintColor = .white
            return cell2
        default:
            cell.textLabel?.text = "🍎"
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 11) {
            print("찜하기")
            wishPost()
        }
    }

    
    func wishPost() {
            let AT : String? = KeyChain.read(key: Token.accessToken)
            let RT : String? = KeyChain.read(key: Token.refreshToken)
            let url = "http://10.156.147.167:8080/api/pet/save"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.timeoutInterval = 10
            var header = HTTPHeaders()
            header.add(name: "Authorization", value: "Bearer \(AT!)")
            header.add(name: "X-Refresh-Token", value: RT!)
                                
        // POST 로 보낼 정보
    let params = ["adoptionStatusCd": "\(pets!.adoptionStatusCD)",
                  "age": "\(pets!.age)",
                  "classification": "\(pets!.classification)",
                  "filePath": "\(pets!.filePath)",
                  "foundPlace": "\(pets!.foundPlace)",
                  "gender": "\(pets!.gender)",
                  "gu": "\(pets!.gu)",
                  "hairColor": "\(pets!.hairColor)",
                  "memo": "\(pets!.memo)",
                  "rescueDate": "\(pets!.rescueDate)",
                  "species": "\(pets!.species)",
                  "weight": "\(pets!.weight)"
                 ] as Dictionary
            
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        request.httpBody = jsonData

        AF.request(url,method: .post,parameters: params, encoding: JSONEncoding.default, headers: header)
            .responseString { (response) in
                switch response.response?.statusCode {
                case 200:
                    print(params)
                    debugPrint(response)
                    print("url 경로 : \(request.url as Any)")
                    print("✅POST 성공✅")
                    let AlertMassge = UIAlertController(title: "알림", message: "찜하기 성공", preferredStyle: UIAlertController.Style.alert)
                    let ActionMassge = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    
                    AlertMassge.addAction(ActionMassge)
                    self.present(AlertMassge, animated: true, completion: nil)
                case 201:
                    print(params)
                    debugPrint(response)
                    print("url 경로 : \(request.url as Any)")
                    print("✅POST 성공✅")
                    let AlertMassge = UIAlertController(title: "알림", message: "찜하기 성공", preferredStyle: UIAlertController.Style.alert)
                    let ActionMassge = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    
                    AlertMassge.addAction(ActionMassge)
                    self.present(AlertMassge, animated: true, completion: nil)
                default:
                    print("🤯post 성공하지 못했습니다🤬")
                    debugPrint(response)
                    debugPrint(params)
            }
        }
    }
}

