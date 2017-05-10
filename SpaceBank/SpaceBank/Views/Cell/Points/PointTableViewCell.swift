//
//  PointTableViewCell.swift
//  SpaceBank
//
//  Created by Sam on 11.05.17.
//  Copyright © 2017 Semyon Vyatkin. All rights reserved.
//

import UIKit

class PointTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    
    class var id: String {
        return NSStringFromClass(PointTableViewCell.self).replacingOccurrences(of: "SpaceBank.", with: "")
    }
    
    // MARK: - Properties
    var title: String? {
        set {
            titleLabel.text = newValue
        }
        get {
            return titleLabel.text
        }
    }
    
    var address: String? {
        set {
            addressLabel.text = newValue
        }
        get {
            return addressLabel.text
        }
    }
    
    var schedule: String? {
        set {
            if newValue?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                scheduleLabel.text = "-"
            }
            else {
                scheduleLabel.text = newValue
            }
        }
        get {
            return scheduleLabel.text
        }
    }
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }        
}
