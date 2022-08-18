//
//  SearchPetList.swift
//  
//
//  Created by 박준하 on 2022/08/18.
//

import UIKit

struct SearchPetList : Codable {
    let adoptionStatusCd : Int
    let age : String
    let classification : Int
    let filePath : String
    let foundPlace : String
    let gender : Int
    let gu : Int
    let hairColor : String
    let memo : String
    let rescueDate : String
    let species : String
    let weight : String
}
//{
//  "searchPetList": [
//    {
//      "adoptionStatusCd": 0,
//      "age": "string",
//      "classification": 0,
//      "filePath": "string",
//      "foundPlace": "string",
//      "gender": 0,
//      "gu": 0,
//      "hairColor": "string",
//      "memo": "string",
//      "rescueDate": "string",
//      "species": "string",
//      "weight": "string"
//    }
//  ]
//}
