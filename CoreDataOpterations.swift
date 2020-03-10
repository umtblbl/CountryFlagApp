//
//  CoreData.swift
//  CountryFlagApp
//
//  Created by Ümit on 5.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct CoreDataOperations {
    
    // AppDelege reference definion
    private static let appDelegete = UIApplication.shared.delegate as! AppDelegate
    // CoreData context definion
    private static let context = appDelegete.persistentContainer.viewContext
    // CoreData FetchRequest instance
    private static let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Country")
    // CoreData DeleteRequest instance
    private static let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    
    //let managedObjectContext = appDelegete.persistentContainer.viewContext
    private static let myPersistentStoreCoordinator = appDelegete.persistentContainer.persistentStoreCoordinator
    
    static func deleteAllCountries() {
        do {
            try myPersistentStoreCoordinator.execute(deleteRequest, with: context)
        } catch let error as NSError {
            print("DELETING ERROR --------------> \(error.description)")
        }
        print("------------ DELETING IS ALL COUNTRIES -----------")
    }
    
    static func getCounries() -> [TableCountry]? {
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let countries = try context.fetch(fetchRequest) as? [NSManagedObject]
            
            var tableCountries = [TableCountry]()
            
            for country in countries! {
                
                let tableCountry = TableCountry()
                
                if let name = country.value(forKey: "name") as? String {

                    if name == "Ecuador" {
                        continue
                    }
                    
                    tableCountry.name = name
                }
                if let flag = country.value(forKey: "flag") as? String {
                    tableCountry.flag = flag
                }
                if let population = country.value(forKey: "population") as? String {
                    tableCountry.population = population
                }
                if let timezones = country.value(forKey: "timezones") as? String {
                    tableCountry.timezones = timezones
                }
                if let capital = country.value(forKey: "capital") as? String {
                    tableCountry.capital = capital
                }
                if let region = country.value(forKey: "region") as? String {
                    tableCountry.region = region
                }
                tableCountries.append(tableCountry)
            }
            
            return tableCountries
        } catch {
            print("Error fetching countries.")
        }
        return nil
    }
    
    static func saveCountryList(countryArray: [[String : Any]]) -> Bool {
        var temp:Int = 0
        for country in countryArray {
            let newCountry = NSEntityDescription.insertNewObject(forEntityName: "Country", into: context)
            newCountry.setValue(UUID(), forKey: "id")
            
            if let population = country["population"] as? Int64 {
                let populate: String = String(population)
                newCountry.setValue(populate, forKey: "population")
                print(population)
            }
            
            if let timezones = country["timezones"] as? [String] {
                newCountry.setValue(timezones[0], forKey: "timezones")
                print(timezones)
            }
            
            if let name = country["name"] as? String {
                newCountry.setValue(name, forKey: "name")
                print(name)
            }
            
            if let flag = country["flag"] as? String {
                newCountry.setValue(flag, forKey: "flag")
                print(flag)
            }
            if let capital = country["capital"] as? String {
                newCountry.setValue(capital, forKey: "capital")
                print(capital)
            }
            if let region = country["region"] as? String {
                newCountry.setValue(region, forKey: "region")
                print(region)
            }
            temp += 1
        }
        
        do {
            try context.save()
            print("CONTEXT SAVE")
        } catch {
            print("Error saving NewCountries.")
            print(temp)
            return false
        }
        print("-------------------------------- INSERTING COUNT = \(temp) --------------------------------")
        return true
    }
}
