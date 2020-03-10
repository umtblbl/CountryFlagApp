//
//  SectionHeaderView.swift
//  CountryFlagApp
//
//  Created by Ümit on 9.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    static let reuseIdentifier: String = String(describing: self)
    
    var title: String = "" {
        didSet {
            lblTitle.text = title
            print(title)
        }
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
