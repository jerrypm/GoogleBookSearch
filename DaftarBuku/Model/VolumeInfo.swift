//
//  VolumeInfo.swift
//
//  Created by Jeri Purnama Maulid on 09/08/18
//  Copyright (c) . All rights reserved.
// judul = items -> volumeInfo -> title ""
// gambar = items -> volumeInfo -> imageLinks -> smallThumbnail/thumbnail ""
// author = items -> volumeInfo ->  authors []
// rating = items -> volumeInfo -> averageRating Int

import Foundation
import SwiftyJSON

public class VolumeInfo: BaseEntity {

  private struct SerializationKeys {
    static let title = "title"
    static let imageLinks = "imageLinks"
    static let authors = "authors"
    static let averageRating = "averageRating"
  }

    public var title: String?
    public var imageLinks: ImageLinks?
    public var authors: [String]?
    public var averageRating: Double?
    
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  public required init(json: JSON) {
    
    if let items = json[SerializationKeys.authors].array { authors = items.map { $0.stringValue } }
    imageLinks = ImageLinks(json: json[SerializationKeys.imageLinks])
    title = json[SerializationKeys.title].string
    averageRating = json[SerializationKeys.averageRating].double
  }

  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
  
    if let value = authors { dictionary[SerializationKeys.authors] = value }
    if let value = imageLinks { dictionary[SerializationKeys.imageLinks] = value.dictionaryRepresentation() }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = averageRating { dictionary[SerializationKeys.averageRating] = value }
  
    return dictionary
  }

}

public class ImageLinks {
    private struct SerializationKeys {
        static let thumbnail = "thumbnail"
        static let smallThumbnail = "smallThumbnail"
    }
    
    public var thumbnail: String?
    public var smallThumbnail: String?

    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
  
    public required init(json: JSON) {
        thumbnail = json[SerializationKeys.thumbnail].string
        smallThumbnail = json[SerializationKeys.smallThumbnail].string
    }

    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = thumbnail { dictionary[SerializationKeys.thumbnail] = value }
        if let value = smallThumbnail { dictionary[SerializationKeys.smallThumbnail] = value }
        return dictionary
    }
    
}
