//
//  CountryDetailViewController.swift
//  CountryFlagApp
//
//  Created by Ümit on 6.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit
import SDWebImageSVGCoder
import SDWebImage

class CountryDetailViewController: UIViewController {

    @IBOutlet weak var ivCountryFlag: UIImageView!
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var lblCapital: UILabel!
    @IBOutlet weak var lblPopulation: UILabel!
    @IBOutlet weak var lblRegion: UILabel!
    @IBOutlet weak var lblTimezone: UILabel!

    var country = TableCountry()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblCountryName.text = country.name
        lblCapital.text = country.capital
        lblPopulation.text = country.population
        lblRegion.text = country.region
        lblTimezone.text = country.timezones
        
        // register coder, on AppDelegate
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
        ivCountryFlag.sd_setImage(with: URL(string: country.flag))
        // Changing size
        var rect =  ivCountryFlag.frame
        rect.size.width = 225
        rect.size.height = 150
        ivCountryFlag.frame = rect
    }
}
