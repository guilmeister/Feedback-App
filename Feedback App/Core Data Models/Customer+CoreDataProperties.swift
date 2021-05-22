//
//  Customer+CoreDataProperties.swift
//  Feedback App
//
//  Created by Edward Guilllermo on 4/30/21.
//
//

import Foundation
import CoreData


extension Customer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer> {
        return NSFetchRequest<Customer>(entityName: "Customer")
    }

    @NSManaged public var username: String?
    @NSManaged public var password: String?
    @NSManaged public var roomScore: Float
    @NSManaged public var gymScore: Float
    @NSManaged public var foodScore: Float
    @NSManaged public var spaScore: Float
    @NSManaged public var overallScore: Float

}

extension Customer : Identifiable {

}
