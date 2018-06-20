//
//  BusProfilViewController.swift
//  WGApp
//
//  Created by Viviane Rehor on 02.06.18.
//  Copyright © 2018 Viviane Rehor. All rights reserved.
//

import UIKit
import CoreData

class BusProfileVC: UIViewController {
    
    

    
    @IBOutlet weak var tableView: UITableView!
    var busSettings = [BusSettings]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //BusSettingsController.addTestBusSettings()
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 0))
        tableView.tableFooterView = footerView
        
        // load core data into table
        self.refreshTable()
        
        for bs in busSettings {
            print(bs.routes!.count)
        }
    }
    
 
    @IBAction func addBusProfile(_ sender: Any) {

        
        // alert
        let alert = UIAlertController(title: "Titel des neuen BusProfils angeben:", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        // titel
        alert.addTextField { (textField) in
            textField.placeholder = "Titel"
        }
        
        // alert button hinzufügen
        let saveAction = UIAlertAction(title: "hinzufügen", style: .default) { (_) in
            let title = alert.textFields!.first!.text!
            var newBusSetting = BusSettings(context: PersistenceService.context);
            newBusSetting.title = title
            //set User = WG
            PersistenceService.saveContext()
            self.refreshTable()
            NotificationCenter.default.post(name: NSNotification.Name("ShowBusprofileMsg"), object: newBusSetting)
        }
        let cancleAction = UIAlertAction(title: "abbrechen", style: .default) { (_) in }
        
        alert.addAction(saveAction)
        alert.addAction(cancleAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    func refreshTable(){
        // load core data into table
        let fetchRequest: NSFetchRequest<BusSettings> = BusSettings.fetchRequest()
        do {
            let profiles = try PersistenceService.context.fetch(fetchRequest)
            self.busSettings = profiles
            self.tableView.reloadData()
        } catch {}
    }
    


    
}

extension BusProfileVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return busSettings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let busProfile = busSettings[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusProfileCell")
        
        let bpCell = cell  as! BusprofileTableViewCell
        
        bpCell.setBusprofile(busSettings: busProfile)
        
        return bpCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name("ShowBusprofileMsg"), object: busSettings[indexPath.row])
    }
    

    
    
    
    
}
