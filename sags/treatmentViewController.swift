//
//  treamentCollectionViewController.swift
//  sags
//
//  Created by Simon Lauridsen on 05/12/2017.
//  Copyright © 2017 Kameli. All rights reserved.
//

//  Kingfisher Framework
//
//  Copyright (c) 2017 Wei Wang
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation
import UIKit
import Kingfisher

class treatmentCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var treatmentHeader: UILabel!
    @IBOutlet weak var treatmentComment: UILabel!
    
    var treatment: [String : Any] = [:]
    var imageArray : [Any] = []
    var treatmentImage : UIImage!
    var commentText : NSString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor(red: 249/255.0, green: 133.0/255.0, blue: 25.0/255.0, alpha: 1.0)
        navigationController?.navigationBar.tintColor = UIColor.white
        
        treatmentHeader.text = self.treatment["behandlingstype"] as? String
        
        let comment = self.treatment["kommentar"] as? String
        if (comment?.isEmpty)! {
            treatmentComment.text = "Ingen kommentarer"
        } else {
            treatmentComment.text = self.treatment["kommentar"] as? String
        }
        
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
        
        let url = URL(string: String(format: "http://sags.suvogaranti.dk/billeder/%@", (treatmentImageDict["billedfil"] as? String)!))
        cell.imageView.kf.setImage(with: url)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell : treatmentCollectionViewCell = collectionView.cellForItem(at: indexPath)! as! treatmentCollectionViewCell
        let image = cell.imageView.image
        let text = cell.commentLabel.text
        
        self.treatmentImage = image!
        self.commentText = text! as NSString
        super.performSegue(withIdentifier: "display_treatment", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionReusableView", for: indexPath)
            // do any programmatic customization, if any, here
            return view
        }
        fatalError("Unexpected kind")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: self.view.frame.size.width/1.33 + 40)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "display_treatment" {
            if segue.destination.isKind(of: displayTreatmentViewController.self)  {
                let displayTreatmentViewController = segue.destination as! displayTreatmentViewController
                displayTreatmentViewController.treatmentImage = self.treatmentImage
                displayTreatmentViewController.commentText = self.commentText
            }
        }
    }
    
    override var supportedInterfaceOrientations:UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
}
