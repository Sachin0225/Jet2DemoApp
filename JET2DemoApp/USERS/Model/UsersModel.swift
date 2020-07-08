//
//  UsersModel.swift
//  JET2DemoApp
//
//  Created by Sachin on 05/07/20.
//  Copyright © 2020 Sachin. All rights reserved.
//

import UIKit
import CoreData

class UsersModel: NSManagedObject, Codable {
    // MARK: - Core Data Managed Object
    @NSManaged var id: String?
    @NSManaged var createdAt: String?
    @NSManaged var name: String?
    @NSManaged var avatar: String?
    @NSManaged var lastname: String?
    @NSManaged var city: String?
    @NSManaged var designation: String?
    @NSManaged var about: String?
    @NSManaged var blogId: String?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt
        case name
        case avatar
        case lastname
        case city
        case designation
        case about
        case blogId
    }
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "UsersModel", in: managedObjectContext) else {
            fatalError("Failed to decode User")
        }
        self.init(entity: entity, insertInto: managedObjectContext)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.avatar = try container.decodeIfPresent(String.self, forKey: .avatar) ?? ""
        self.lastname = try container.decodeIfPresent(String.self, forKey: .lastname) ?? ""
        self.city = try container.decodeIfPresent(String.self, forKey: .city) ?? ""
        self.designation = try container.decodeIfPresent(String.self, forKey: .designation) ?? ""
        self.about = try container.decodeIfPresent(String.self, forKey: .about) ?? ""
        self.blogId = try container.decodeIfPresent(String.self, forKey: .blogId) ?? ""
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(name, forKey: .name)
        try container.encode(avatar, forKey: .avatar)
        try container.encode(lastname, forKey: .lastname)
        try container.encode(city, forKey: .city)
        try container.encode(designation, forKey: .designation)
        try container.encode(about, forKey: .about)
        try container.encode(blogId, forKey: .blogId)
    }
}
