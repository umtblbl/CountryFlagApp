//
//  CountriesPresenter.swift
//  CountryFlagApp
//
//  Created by Ümit on 5.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import CoreData

protocol CountriesViewDelegate: class {
    func displayCountries(countries: [TableCountry])
    func displayCountrySection(countrySectionArray: [CountrySection])
}

class CountriesPresenter {
    
    weak private var countriesViewDelegate : CountriesViewDelegate?
    
    init() {}
    
    func setViewDelegate(countriesViewDelegate: CountriesViewDelegate){
        self.countriesViewDelegate = countriesViewDelegate
    }
    
    func fetchCountries() {
        if let tableCountries = CoreDataOperations.getCounries() as [TableCountry]? {
            self.countriesViewDelegate?.displayCountries(countries: tableCountries)
        }
    }
    
    func getAndSaveCountries() {
        Service.getCountryDetails(completion: {( result, error ) in
            if let countries = result {
                let countriesSaveState = CoreDataOperations.saveCountryList(countryArray: countries)
                
                if countriesSaveState {
                    UserDefaults.standard.set(true, forKey: "DBSaveState")
                }
                else {
                    UserDefaults.standard.set(false, forKey: "DBSaveState")
                }
            }
        })
    }
    
    func prepareCountries(countries: [TableCountry]) {
        
        var countrySectionArray = [CountrySection]()
        var countrySection: CountrySection
        
        if let firstName = countries.first?.name[0] {
            countrySection = CountrySection.init(characterName: firstName)
        }
        else {
             countrySection = CountrySection.init(characterName: "!")
        }
        
        for i in 0..<(countries.count-1) {
            
            if i == 0 {
                countrySection.countries.append(countries[i])
            }
            
            else if countries[i].name[0] != countries[i-1].name[0] {
                countrySectionArray.append(countrySection)
                countrySection = CountrySection.init(characterName: countries[i].name[0])
                countrySection.countries.append(countries[i])
            }
            else if countries[i].name[0] == countries[i-1].name[0] {
                countrySection.countries.append(countries[i])
            }
            
            if countries.count == i+2 {
                 countrySectionArray.append(countrySection)
            }
        }
        
        self.countriesViewDelegate?.displayCountrySection(countrySectionArray: countrySectionArray)
    }
}




