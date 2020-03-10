//
//  TableCountry.swift
//  CountryFlagApp
//
//  Created by Ümit on 5.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

class TableCountry {
    var name: String = ""
    var flag: String = ""
    var population: String = ""
    var timezones: String = ""
    var capital: String = ""
    var region: String = ""
    
    init() {}
    
    init(name: String, flag: String, population: String, timezones: String) {
        self.name = name
        self.flag = flag
        self.population = population
        self.timezones = timezones
    }
}
