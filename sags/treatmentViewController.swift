//
//  treamentCollectionViewController.swift
//  sags
//
//  Created by Simon Lauridsen on 05/12/2017.
//  Copyright © 2017 Kameli. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class treatmentCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var treatmentHeader: UILabel!
    @IBOutlet weak var treatmentComment: UILabel!
    
    var treatment: [String : Any] = [:]
    var imageArray : [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        treatmentHeader.text = self.treatment["behandlingstype"] as? String
        treatmentComment.text = self.treatment["kommentar"] as? String
        imageArray = treatment["billeder"] as! [Any]
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! treatmentCollectionViewCell
        configureCell(cell: cell, forItemAtIndexPath: indexPath)
        
        return cell
    }
    
    func configureCell(cell: treatmentCollectionViewCell, forItemAtIndexPath: IndexPath) {
        let treatmentImageDict = imageArray[forItemAtIndexPath.item] as! [String : Any]
        cell.commentLabel.text = treatmentImageDict["billedbem"] as? String
        
        let url = URL(string: (treatmentImageDict["billedfil"] as? String)!)!
        cell.imageView.kf.setImage(with: url)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }
}
