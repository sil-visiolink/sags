//
//  ViewController.swift
//  sags
//
//  Created by Simon Lauridsen on 28/11/2017.
//  Copyright © 2017 Kameli. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var pinCodeTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var jsonObject: [String : Any] = [:]
    var suvoData = customerData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_sender: UIButton) {
        guard let cardNumberText = cardNumberTextField.text, !cardNumberText.isEmpty, let pinCodeText = pinCodeTextField.text, !pinCodeText.isEmpty else {
            return
        }
        
        let urlComp = NSURLComponents(string: "http://sags.suvogaranti.dk/mobil_garanti.asp")!
        
        var items = [URLQueryItem]()
        items.append(URLQueryItem(name:"kortnr", value: cardNumberTextField?.text ?? ""))
        items.append(URLQueryItem(name:"kortpin", value: pinCodeTextField?.text ?? ""))
        
        items = items.filter{!$0.name.isEmpty}
        
        if !items.isEmpty {
            urlComp.queryItems = items
        }
        
        var urlRequest = URLRequest(url: urlComp.url!)
        urlRequest.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                DispatchQueue.main.async(execute: {
                    if(httpResponse.statusCode == 200) {
                        if let data = data {
                            do {
                                let json : [Any] = ([try JSONSerialization.jsonObject(with: data, options: .allowFragments) as Any])

                                let array : [Any] = [json[0] as Any]
                                self.jsonObject = array[0] as! [String : Any]
                                
                                if(self.jsonObject.count == 1) {
                                    let errorMessage = self.jsonObject["fejl"] as! String
                                    let alert = UIAlertController(title: "Fejl ved login", message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                } else {
                                     self .setupCustomerData(object: self.jsonObject)
                                     super.performSegue(withIdentifier: "login_success", sender: nil)
                                }
                            }catch {
                                print(error)
                            }
                        }
                    }
                })
            }
        })
        task.resume()
    }
    
    func setupCustomerData(object : [String : Any]) {
        suvoData.carModel = String(format: "%@ %@", object["bilfabrikant"] as! String, object["bilmodel"] as! String)
        suvoData.regDate = object["firstreg"] as! String
        suvoData.regNr = object["nrplade"] as! String
        suvoData.VIN = object["stelnr"] as! String
        suvoData.warrantyPeriod = object["garantiperiode"] as! String
        suvoData.expirationDate = object["garantislut"] as! String
        let treatmentArray : [Any] = [object["behandlinger"] as Any]
        suvoData.treatments = [treatmentArray[0] as Any]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login_success" {
            if let navigationController = segue.destination as? UINavigationController {
                if let frontPage = navigationController.viewControllers.first as? frontPageViewController {
                    frontPage.suvoData = suvoData
                }
            }
            
        }
        
    }
}

