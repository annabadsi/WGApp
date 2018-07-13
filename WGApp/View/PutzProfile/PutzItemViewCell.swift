//
//  PutzItemViewCell.swift
//  WGApp
//
//  Created by Viviane Rehor on 13.07.18.
//  Copyright © 2018 Viviane Rehor. All rights reserved.
//

import UIKit

class PutzItemViewCell: UICollectionViewCell {

    @IBOutlet weak var putzItemImageView: UIImageView!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var putzProfileTitle: UILabel!
    
    var putzItem:PutzWeekItem?
    
    func setPutzItem(putzProfile: PutzSetting, startDate: Date) {
        var putzItem = getPutzItem(putzProfile: putzProfile, startDate: startDate)
        let outFormatter = DateFormatter()
        outFormatter.dateFormat = "dd.MM.yy"
        if let putzItem = putzItem {
            self.putzItem = putzItem
            putzItemImageView.image = UIImage(named: "Fish-icon")

            putzProfileTitle.text = "Sec " + (putzProfile.title)! + "/Item " + outFormatter.string(from: startDate)
            let userIconString = putzItem.user?.profilIcon
            if userIconString != nil, let image = UIImage(named: userIconString!) {
                userImageView.image = image
            } else {
                userImageView.image = UIImage(named: "Bear-icon")
                print("Picture of putzprofile could not be loaded !!! ")
            }
        } else {
            //self.isHidden = true
        }
    }
    
    func getPutzItem(putzProfile: PutzSetting, startDate: Date) -> PutzWeekItem? {
        for item in putzProfile.weekItems! {
            if (startDate == ((item as! PutzWeekItem).weekStartDay! as Date) ) {
                return (item as! PutzWeekItem)
            }
        }
        return nil
    }

}