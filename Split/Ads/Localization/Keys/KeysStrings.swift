//
//  KeysStrings.swift
//  Split
//
//  Created by David Para on 4/27/19.
//  Copyright © 2019 parad. All rights reserved.
//

import Foundation

enum KeysStrings: String, Localizable {
    case adMobApplicationIdentifier = "ad_mob_application_identifier"
    case adMobDebugIdentifier = "ad_mob_debug_identifier"
    
    var tableName: String {
        return "Keys"
    }
}
