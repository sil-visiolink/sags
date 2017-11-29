//
//  frontPageViewController.swift
//  sags
//
//  Created by Simon Lauridsen on 28/11/2017.
//  Copyright © 2017 Kameli. All rights reserved.
//

import UIKit

class frontPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var carBrand: UILabel!
    @IBOutlet weak var regDate: UILabel!
    @IBOutlet weak var regNr: UILabel!
    @IBOutlet weak var VIN: UILabel!
    @IBOutlet weak var warrantyPeriod: UILabel!
    @IBOutlet weak var expirationDate: UILabel!
    @IBOutlet weak var treatmentsTableView: UITableView!
    
    var suvoData = customerData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        carBrand.text = suvoData.carModel
        regDate.text = suvoData.regDate
        regNr.text = suvoData.regNr
        VIN.text = suvoData.VIN
        warrantyPeriod.text = suvoData.warrantyPeriod
        expirationDate.text = suvoData.expirationDate
        
        treatmentsTableView.delegate = self
        treatmentsTableView.dataSource = self
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suvoData.treatments.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "mycell")
        return cell
    }
    
}
