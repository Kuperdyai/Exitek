//
//  Device+CoreDataProperties.swift
//  ExitekTest
//
//  Created by Александр on 05.09.2022.
//
//

import Foundation
import CoreData


extension Device {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Device> {
        return NSFetchRequest<Device>(entityName: "Device")
    }

    @NSManaged public var imei: String?
    @NSManaged public var model: String?
    var mobile : Mobile {
               get {
                   return Mobile(imei: self.imei!, model: self.model!)
                }
                set {
                    self.imei = newValue.imei
                    self.model = newValue.model
                }
             }

}

extension Device : Identifiable {

}
