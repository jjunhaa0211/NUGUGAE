//
//  SavePet.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/08/18.
//

import Foundation

// MARK: - Welcome
struct SavePet: Codable {
    let adoptionStatusCD: Int
    let age: String
    let classification: Int
    let filePath, foundPlace: String
    let gender, gu: Int
    let hairColor, memo, rescueDate, species: String
    let weight: String

    enum CodingKeys: String, CodingKey {
        case adoptionStatusCD = "adoptionStatusCd"
        case age, classification, filePath, foundPlace, gender, gu, hairColor, memo, rescueDate, species, weight
    }
}
