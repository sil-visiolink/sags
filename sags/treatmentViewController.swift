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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
//        cell.commentLabel.text = treatmentImageDict["billedbem"] as? String
        cell.commentLabel.text = "HEST"
        
        let url = URL(string: String(format: "http://sags.suvogaranti.dk/billeder/%@", (treatmentImageDict["billedfil"] as? String)!))
        cell.imageView.kf.setImage(with: url)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: self.view.frame.size.width/1.33 + 40)
    }
}
