//
//  ArticlesModel.swift
//  JET2DemoApp
//
//  Created by Sachin on 06/07/20.
//  Copyright © 2020 Sachin. All rights reserved.
//

import UIKit
import CoreData

class ArticlesModel: NSManagedObject, Codable {
    // MARK: - Core Data Managed Object
    @NSManaged var id: String?
    @NSManaged var createdAt: String?
    @NSManaged var content: String?
    @NSManaged var comments: Int
    @NSManaged var likes: Int
    @NSManaged var media: Set<MediaModel>?
    @NSManaged var user: Set<UsersModel>?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "createdAt"
        case content = "content"
        case comments = "comments"
        case likes = "likes"
        case media = "media"
        case user = "user"
    }
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "ArticlesModel", in: managedObjectContext) else {
            fatalError("Failed to decode User")
        }

        self.init(entity: entity, insertInto: managedObjectContext)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
        self.content = try container.decodeIfPresent(String.self, forKey: .content) ?? ""
        self.comments = try container.decodeIfPresent(Int.self, forKey: .comments) ?? 0
        self.likes = try container.decodeIfPresent(Int.self, forKey: .likes) ?? 0
        self.media = try container.decodeIfPresent(Set<MediaModel>.self, forKey: .media) ?? []
//        self.media = NSSet(array: try container.decode([MediaModel].self, forKey: .media))
        self.user = try container.decodeIfPresent(Set<UsersModel>.self, forKey: .user) ?? []
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(content, forKey: .content)
        try container.encode(comments, forKey: .comments)
        try container.encode(likes, forKey: .likes)
//        try container.encode(media, forKey: .media)
//        try container.encode(user, forKey: .user)
    }
}

class MediaModel: NSManagedObject, Codable {
    // MARK: - Core Data Managed Object
    @NSManaged var id: String?
    @NSManaged var blogId: String?
    @NSManaged var createdAt: String?
    @NSManaged var image: String?
    @NSManaged var title: String?
    @NSManaged var url: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case blogId = "blogId"
        case createdAt = "createdAt"
        case image = "image"
        case title = "title"
        case url = "url"
    }
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "MediaModel", in: managedObjectContext) else {
            fatalError("Failed to decode User")
        }

        self.init(entity: entity, insertInto: managedObjectContext)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
        self.blogId = try container.decodeIfPresent(String.self, forKey: .blogId) ?? ""
        self.image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(blogId, forKey: .blogId)
        try container.encode(image, forKey: .image)
        try container.encode(title, forKey: .title)
        try container.encode(url, forKey: .url)
    }
}
