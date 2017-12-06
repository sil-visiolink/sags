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
    
    var selectedTreatment: [String : Any] = [:]
    var suvoData = customerData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 249/255.0, green: 133.0/255.0, blue: 25.0/255.0, alpha: 1.0)
        navigationController?.navigationBar.tintColor = UIColor.white
        
        carBrand.text = suvoData.carModel
        regDate.text = suvoData.regDate
        regNr.text = suvoData.regNr
        VIN.text = suvoData.VIN
        warrantyPeriod.text = suvoData.warrantyPeriod
        expirationDate.text = suvoData.expirationDate
        
        treatmentsTableView.delegate = self
        treatmentsTableView.dataSource = self
    }
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        suvoData = customerData()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Behandlinger"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suvoData.treatments.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        
        var treatmentArray = suvoData.treatments[indexPath.row] as! [Any]
        var treatments = treatmentArray[0] as! [String : Any]
        cell.textLabel?.text = treatments["dato"] as? String
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var treatmentArray = suvoData.treatments[indexPath.row] as! [Any]
        self.selectedTreatment = treatmentArray[0] as! [String : Any]
        super.performSegue(withIdentifier: "treatment_selected", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "treatment_selected" {
            if segue.destination.isKind(of: treatmentCollectionViewController.self)  {
                let treatmentCollectionViewController = segue.destination as! treatmentCollectionViewController
                treatmentCollectionViewController.treatment = self.selectedTreatment
            }
        }
    }
    
}
