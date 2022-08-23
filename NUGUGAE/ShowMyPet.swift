//
//  ShowMyPet.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/08/23.
//

import Foundation

// MARK: - Welcome
struct ShowMyPet: Codable {
    let ShowpPets: [Pet]
}

// MARK: - Pet
struct Pet: Codable {
    let id : Int
    let adoptionStatusCD: Int
    let age: String
    let classification: Int
    let filePath: String
    let foundPlace: String
    let gender: Int
    let gu: Int
    let hairColor: String
    let memo: String
    let rescueDate : String
    let species: String
    let weight: String

    enum CodingKeys: String, CodingKey {
        case id
        case adoptionStatusCD = "adoptionStatusCd"
        case age, classification, filePath, foundPlace, gender, gu, hairColor, memo, rescueDate, species, weight
    }
}
//{
//"pets": [
//  {
//    "id": 0,
//    "adoptionStatusCd": 0,
//    "age": "string",
//    "classification": 0,
//    "filePath": "string",
//    "foundPlace": "string",
//    "gender": 0,
//    "gu": 0,
//    "hairColor": "string",
//    "memo": "string",
//    "rescueDate": "string",
//    "species": "string",
//    "weight": "string"
//  }
//]
//}
