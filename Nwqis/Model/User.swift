//
//  User.swift
//  Nwqis
//
//  Created by Farido on 1/12/20.
//  Copyright © 2020 Farido. All rights reserved.
//

import Foundation
import AuthenticationServices

struct User {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    
    init(credentials: ASAuthorizationAppleIDCredential) {
        self.id = credentials.user
        self.firstName = credentials.fullName?.givenName ?? ""
        self.lastName =	credentials.fullName?.familyName ?? ""
        self.email = credentials.email ?? ""
    }
}

extension User: CustomDebugStringConvertible {
    var debugDescription: String {
        return """
        ID: \(id)
        Frist Name: \(firstName)
        Last Name: \(lastName)
        Email: \(email)
        """
    }
}
