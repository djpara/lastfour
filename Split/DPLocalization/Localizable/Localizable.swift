//
//  Localizable.swift
//  Split
//
//  Created by David Para on 12/7/18.
//  Copyright © 2018 David Para. All rights reserved.
//

import Foundation

// MARK: - Localizable Protocol

protocol Localizable {
    var tableName: String { get }
    var localized: String { get }
}

// MARK: - Localizable extension

// Extend the extension only if self is a string and conforms to RawRepresentable -- enums conform to this protocol by default
// Ref: https://medium.com/@marcosantadev/app-localization-tips-with-swift-4e9b2d9672c9
extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var localized: String {
        return rawValue.localized(fromTable: tableName)
    }
}

// MARK: - String extension

extension String {
    func localized(fromTable name: String, bundle: Bundle = .main) -> String {
        return NSLocalizedString(self, tableName: name, bundle: bundle, value: "**\(self)**", comment: "")
    }
}
