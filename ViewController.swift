//
//  ViewController.swift
//  CountryFlagApp
//
//  Created by Ümit on 4.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit
import Kingfisher
import PocketSVG
import SDWebImage
import SDWebImageSVGCoder

class ViewController: UIViewController, CountriesViewDelegate, CountryCellDelegate {
    
    @IBOutlet weak var tvcCountries: UITableView!
    
    let countriesCellId = "CountryTableViewCell"
    let countriesTitleCellId = "CountryTitleTableViewCell"
    
    private let presenter = CountriesPresenter()
    var selectedCountry = TableCountry()
    
    var countrySections = [CountrySection]() {
        didSet {
            tvcCountries.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setViewDelegate(countriesViewDelegate: self)
        let dbSaveState = UserDefaults.standard.bool(forKey: "DBSaveState")
        
        /*If the data was previously pulled from the api, bring it from the database
            If no data was previously captured, pull the data and write the database */
        if !dbSaveState {
            presenter.getAndSaveCountries()
            presenter.fetchCountries()
        }
        else { presenter.fetchCountries() }
        
        tvcCountries.register(UINib.init(nibName: countriesCellId, bundle: nil), forCellReuseIdentifier: countriesCellId)
        tvcCountries.rowHeight = UITableView.automaticDimension
        tvcCountries.separatorColor = UIColor.clear
        
        //To delete all the data in x
        //CoreDataOperations.deleteAllCountries()
        
        self.tvcCountries.register(SectionHeaderView.nib, forHeaderFooterViewReuseIdentifier: SectionHeaderView.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //if the data was previously pulled from apo, fetch it from the database, otherwise if it is not in the database, fetch it from api
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCountryDetailVC" {
            let destinationVC = segue.destination as? CountryDetailViewController
            destinationVC?.country = selectedCountry
            destinationVC?.title = selectedCountry.name
        }
    }
    
    func displayCountries(countries: [TableCountry]) {
        //Sorting alphabetically
        let tableCountries = countries.sorted {
            $0.name < $1.name
        }
        print("################## FETCHING COUNT = \(countries.count) #######################")
        presenter.prepareCountries(countries: tableCountries)
        
    }
    
    func displayCountrySection(countrySectionArray: [CountrySection]) {
        self.countrySections = countrySectionArray
    }
    
    func countryInfoTapped(countryCell: CountryTableViewCell) {
        
        print("ViewController - btnInfoTapped")
        if let country = countryCell.country {
            let alert = UIAlertController(title: "Capital", message: "\(country.capital)", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return countrySections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countrySections[section].countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: countriesCellId, for: indexPath) as? CountryTableViewCell {
            
            let section = countrySections[indexPath.section]
            let row = section.countries[indexPath.row]
            
            cell.country = row
            
            return cell
        }
        else {
            return UITableViewCell.init()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countrySections[indexPath.section].countries[indexPath.row]
        selectedCountry = country
        performSegue(withIdentifier: "toCountryDetailVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView( withIdentifier: SectionHeaderView.reuseIdentifier) as? SectionHeaderView
            else { return nil }
        
        view.title = countrySections[section].characterName
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 250.0
    }
}

