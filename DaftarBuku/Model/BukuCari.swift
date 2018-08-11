//
//  BukuCari.swift
//
//  Created by Jeri Purnama Maulid on 09/08/18
//  Copyright (c) . All rights reserved.
//

import Foundation

public class BukuCari {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let totalItems = "totalItems"
    static let kind = "kind"
    static let items = "items"
  }

  // MARK: Properties
  public var totalItems: Int?
  public var kind: String?
  public var items: [Items]?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    totalItems = json[SerializationKeys.totalItems].int
    kind = json[SerializationKeys.kind].string
    if let items = json[SerializationKeys.items].array { items = items.map { Items(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = totalItems { dictionary[SerializationKeys.totalItems] = value }
    if let value = kind { dictionary[SerializationKeys.kind] = value }
    if let value = items { dictionary[SerializationKeys.items] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

}
