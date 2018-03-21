//
//  frontPageViewController.swift
//  sags
//
//  Created by Simon Lauridsen on 28/11/2017.
//  Copyright © 2017 Kameli. All rights reserved.
//

import UIKit

class treatmentTableViewCell: UITableViewCell {
    @IBOutlet weak var treatmentLabel: UILabel!
    @IBOutlet weak var treatmentImageView: UIImageView!
}

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
    var treatments : [Any] = []
    
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
        
        treatments = suvoData.treatments.reversed()
        
        self.navigationController?.delegate = self as! UINavigationControllerDelegate
    }
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        suvoData = customerData()
        UserDefaults.standard.removeObject(forKey:"user")
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view : UIView = UIView(frame: CGRect(x: treatmentsTableView.bounds.origin.x,y: treatmentsTableView.bounds.origin.y,width: treatmentsTableView.frame.size.width,height: 40))
        let headerLabel : UILabel = UILabel(frame: CGRect(x: 8, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        headerLabel.font = UIFont.boldSystemFont(ofSize: 28)
        headerLabel.textColor = UIColor(red: 249.0/255.0, green: 133.0/255.0, blue: 25.0/255.0, alpha: 1.0)
        headerLabel.text = "Behandlinger"
        view.addSubview(headerLabel)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Behandlinger"
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suvoData.treatments.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! treatmentTableViewCell
        
        var treatment = treatments[indexPath.row] as! [String : Any]
        cell.treatmentLabel?.text = treatment["dato"] as? String
        cell.treatmentImageView?.image = UIImage(named: "right_arrow")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedTreatment = suvoData.treatments[indexPath.row] as! [String : Any]
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
    
    override var supportedInterfaceOrientations:UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
}
