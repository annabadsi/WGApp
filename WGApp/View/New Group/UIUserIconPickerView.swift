//
//  UIUserIconPickerView.swift
//  WGApp
//
//  Created by Anna Abad on 18.06.18.
//  Copyright © 2018 Viviane Rehor. All rights reserved.
//

import UIKit

class UIUserIconPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // TODO: load images from assets
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func getAssets(){
        print("assets?")
        if let path = Bundle.main.path(forResource: "assets/userIcons", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                print("data: ", data)
            }
            catch {
                // let jsonObj = JSON(data: data)
                print("error"); // error in the above string (in this case, yes)!
            }
        }
    }
    private let userIcons:[Image] = [
        Image(named: "Bat-icon"),
        Image(named: "Bear-icon"),
        Image(named: "Beaver-icon"),
        Image(named: "Bee-icon"),
        Image(named: "Bull-icon"),
        Image(named: "Cat-icon"),
        Image(named: "Chicken-icon")
    ]
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
        self.dataSource = self
    }
    
    var placementAnswer = ""
    
    var selectedIconName:String{
        set {
            placementAnswer = newValue
            setActualImage()
        }
        get {
            if placementAnswer == "" {
                placementAnswer = userIcons[0].name!
            }
            return placementAnswer
        }
    }
    
    func setActualImage(){
        for index in 0...userIcons.count {
            if userIcons[index].name == selectedIconName{
                super.selectRow(index, inComponent: 0, animated: true)
                break
            }
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userIcons.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let iconView = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width, height: 60))
        let iconImageView = UIImageView(frame: CGRect(x: (pickerView.bounds.width/2)-25, y: 0, width: 50, height: 50))
        
        iconImageView.image = userIcons[row].image
        iconView.addSubview(iconImageView)
        
        return iconView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        placementAnswer = userIcons[row].name!
    }
}
