//
//  Constants.swift
//  Chatify
//
//  Created by Dipika Kansara on 11/8/21.
//

import Foundation



struct Constants {
    
    static let registerSegue = "RegisterTochat"
    static let LoginSegue = "LoginTochat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}



