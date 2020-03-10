//
//  CountryTableViewswift
//  CountryFlagApp
//
//  Created by Ümit on 5.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit
import SDWebImageSVGCoder
import SDWebImage

protocol CountryCellDelegate: AnyObject {
    func countryInfoTapped(countryCell: CountryTableViewCell)
}

class CountryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivCountryFlag: UIImageView!
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var lblCountryPopulation: UILabel!
    
    @IBOutlet weak var btnInfo: UIButton!
    
    weak var delegate : CountryCellDelegate?
    
    var country: TableCountry? {
        didSet {
            if let country = country {
                
                lblCountryName.text = country.name
                
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
    }
    
    @IBAction func btnTap(_ sender: UIButton) {
        print("TableViewCell - Click Button2")
        self.delegate?.countryInfoTapped(countryCell: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
