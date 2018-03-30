//
//  customerData.swift
//  sags
//
//  Created by Simon Lauridsen on 29/11/2017.
//  Copyright © 2017 Kameli. All rights reserved.
//

import Foundation

class customerData: NSObject {
    var carModel : String = ""
    var regDate : String = ""
    var regNr : String = ""
    var VIN : String = ""
    var warrantyPeriod : String = ""
    var expirationDate : String = ""
    var treatments : [treatmentData] = []
}
