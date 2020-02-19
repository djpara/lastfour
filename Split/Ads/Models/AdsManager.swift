//
//  AdsManager.swift
//  Split
//
//  Created by David Para on 2/17/20.
//  Copyright © 2020 parad. All rights reserved.
//

import Foundation

class AdsManager {
    // MARK: - Static Variables
    // MARK: Internal
    
    static let shared = AdsManager()
    
    // MARK: - Instance Variables
    // MARK: Internal
    
    private(set) var adUnitID: String
    
    // MARK: - Initializers
    // MARK: Private
    
    private init() {
        adUnitID = ""
        #if DEBUG
        adUnitID = KeysStrings.adMobDebugIdentifier.localized
        #else
        adUnitID = KeysStrings.adMobApplicationIdentifier.localized
        #endif
    }
}
