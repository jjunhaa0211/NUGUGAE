//
//  PetList.swift
//  
//
//  Created by 박준하 on 2022/08/18.
//

import Foundation

//입양된 펫 목록 보여주기

struct PetList : Codable {
    let petLists : [Pet]
}

struct Pet : Codable {
    let id : Int
    let filePath : String
    let user : [Users]
}

struct Users : Codable {
    let userId : String
    let name : String
    let email : String
}
