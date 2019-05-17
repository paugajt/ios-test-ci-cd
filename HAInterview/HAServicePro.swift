//
//  HAServicePro.swift
//  HAInterview
//
//  Created by Pauga, Justin on 12/26/18.
//  Copyright © 2018 Pauga. All rights reserved.
//

import Foundation

struct HAServicePro : Codable {
    var entityId : String?
    var companyName : String?
    var ratingCount : String?
    var compositeRating : String?
    var companyOverview : String?
    var phoneNumber : String?
    var servicesOffered : String?
    var specialty : String?
    var primaryLocation : String?
    var email : String?
    
    init() { }
    
    init(dictionary: [String: AnyObject]) {
        
        if let entityId = dictionary["entityId"] {
            self.entityId = entityId as? String
        }
        if let companyName = dictionary["companyName"] {
            self.companyName = companyName as? String
        }
        if let ratingCount = dictionary["ratingCount"] {
            self.ratingCount = ratingCount as? String
        }
        if let compositeRating = dictionary["compositeRating"] {
            self.compositeRating = compositeRating as? String
        }
        if let companyOverview = dictionary["companyOverview"] {
            self.companyOverview = companyOverview as? String
        }
        if let phoneNumber = dictionary["phoneNumber"] {
            self.phoneNumber = phoneNumber as? String
        }
        if let servicesOffered = dictionary["servicesOffered"] {
            self.servicesOffered = servicesOffered as? String
        }
        if let specialty = dictionary["specialty"] {
            self.specialty = specialty as? String
        }
        if let primaryLocation = dictionary["primaryLocation"] {
            self.primaryLocation = primaryLocation as? String
        }
        if let email = dictionary["email"] {
            self.email = email as? String
        }
    }
    
//    enum CodingKeys: String, CodingKey {
//        case entityId, companyName, ratingCount, compositeRating, companyOverview, phoneNumber, servicesOffered, specialty, primaryLocation, email
//    }
//
//    init(from decoder: Decoder) throws {
//        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
//
//        self.entityId = try valueContainer.decode(String.self, forKey: CodingKeys.entityId)
//        self.companyName = try valueContainer.decode(String.self, forKey: CodingKeys.companyName)
//        self.ratingCount = try valueContainer.decode(String.self, forKey: CodingKeys.ratingCount)
//        self.compositeRating = try valueContainer.decode(String.self, forKey: CodingKeys.compositeRating)
//        self.companyOverview = try valueContainer.decode(String.self, forKey: CodingKeys.companyOverview)
//        self.phoneNumber = try valueContainer.decode(String.self, forKey: CodingKeys.phoneNumber)
//        self.servicesOffered = try valueContainer.decode(String.self, forKey: CodingKeys.servicesOffered)
//        self.specialty = try valueContainer.decode(String.self, forKey: CodingKeys.specialty)
//        self.primaryLocation = try valueContainer.decode(String.self, forKey: CodingKeys.primaryLocation)
//        self.email = try valueContainer.decode(String.self, forKey: CodingKeys.email)
//    }
}
