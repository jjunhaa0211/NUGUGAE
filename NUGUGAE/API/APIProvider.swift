//
//  APIProvider.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/06/27.
//

import Foundation

enum AuthAPI : API {
    
    case lagin
    case signup
    case emailcheck
    
    func path() -> String{
        switch self {
        case.lagin:
            return "/signin"
        case.signup:
            return "/signin"
        case.emailcheck:
            return "/email"
        }
    }
}
