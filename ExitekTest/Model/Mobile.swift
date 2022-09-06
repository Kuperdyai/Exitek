//
//  Mobile.swift
//  ExitekTest
//
//  Created by Александр on 04.09.2022.
//

import Foundation

public struct Mobile: Hashable {
let imei: String
let model: String
    
    public static func == (lhs: Mobile, rhs: Mobile) -> Bool {
        return lhs.imei == rhs.imei && lhs.model == rhs.model
    }
}

protocol MobileStorage {
func getAll() -> Set<Mobile>
func findByImei(_ imei: String) -> Mobile?
func save(_ mobile: Mobile) throws -> Mobile
func delete(_ product: Mobile) throws
func exists(_ product: Mobile) -> Bool
}
