//
//  displayTreatmentViewController.swift
//  sags
//
//  Created by Simon Lauridsen on 20/03/2018.
//  Copyright © 2018 Kameli. All rights reserved.
//

import UIKit

class displayTreatmentViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    var treatmentImage : UIImage!
    var commentText : NSString = ""
    
    override func viewDidLoad() {
        imageView.image = treatmentImage
        if(commentText.length > 0) {
            textView.alpha = 1.0
            textView.text = commentText as String!
            textView.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.3)
        } else {
            textView.alpha = 0.0
        }
    }
}
