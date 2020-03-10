//
//  Common.swift
//  CountryFlagApp
//
//  Created by Ümit on 5.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
struct ServiceConstant {
    static let COUNTRY_URL: String = "https://restcountries.eu/rest/v2/all"
}

extension String {
    subscript(i: Int) -> String {
        if self.count == 0 {
            return ""
        }
        return String(self[index(startIndex, offsetBy: i)])
    }
}
