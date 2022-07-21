//
//  Header.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/06/27.
//

import Foundation
import Alamofire
import Security

class Token {
    static let accessToken = "access_token"
    static let refreshToken = "refresh_token"
}

class KeyChain {
    // Create
    class func create(key: String, token: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword, // 일반 암호 항목을 나타내는 값입니다
            kSecAttrAccount: key,   // 저장할 Account
            kSecValueData: token.data(using: .utf8, allowLossyConversion: false) as Any   // 저장할 Token
        ]
        SecItemDelete(query)
        // Keychain은 Key값에 중복이 생기면, 저장할 수 없기 때문에 먼저 Delete해줌
        let status = SecItemAdd(query, nil) // 추가시켜주는 코드인데 추가 하지 못하면 nil을 전달합니다
        assert(status == noErr, "🥵 token을 저장하지 못했습니다")
    }

    // Read
    class func read(key: String) -> String? {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue as Any,  // CFData 타입으로 불러오라는 의미
            kSecMatchLimit: kSecMatchLimitOne       // 중복되는 경우, 하나의 값만 불러오라는 의미
        ]

        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef) // 찾고자하는 것을 찾는 코드입니다

        if status == errSecSuccess {
            if let retrievedData: Data = dataTypeRef as? Data {
                let value = String(data: retrievedData, encoding: String.Encoding.utf8)
                return value
            } else { return nil }
        } else {
            print("🥵 실패 상태코드 = \(status)")
            return nil
        }
    }

    // Delete
    class func delete(key: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        let status = SecItemDelete(query) // 삭제하고 싶은 거 삭제하는 명령어
        assert(status == noErr, "🥵 실패 상태코드 = \(status)")
    }
}

//
enum Header {
    case accesstoken, tokenIsEmpty, refreshToken
    
    func header() -> HTTPHeaders {
        guard let token = KeyChain.read(key: Token.accessToken) else{
            return ["Content-Type" : "application/json"]
        }
        guard let refreshtoken = KeyChain.read(key: Token.refreshToken) else{
            return ["Content-Type" : "application/json"]
        }
        
        switch self {
        case .accesstoken:
            return HTTPHeaders(["Authorization" : "Bearer " + token, "Content-Type" : "application/json"])
        case .tokenIsEmpty:
            return HTTPHeaders(["Content-Type" : "application/json"])
        case .refreshToken:
            return HTTPHeaders(["Authorization" : "Bearer " + refreshtoken, "Content-Type" : "application/json"])
        }
    }
}
