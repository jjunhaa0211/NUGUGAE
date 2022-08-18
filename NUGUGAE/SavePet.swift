//
//  SavePet.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/08/18.
//

import Foundation

struct SavePet : Codable {
    let adoptionStatusCd : Int
    let age : String
    let classification : Int
    let filePath : String
    let foundPlace : String
    let gender: String
    let gn : Int
    let hairColor : String
    let memo : String
    let rescueDate : String
    let species : String
    let weight : String
}
