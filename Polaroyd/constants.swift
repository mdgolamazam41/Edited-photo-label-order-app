//
//  constants.swift
//  Wedding Shot
//
//  Created by USER on 10/15/16.
//  Copyright © 2016 FV iMAGINATION. All rights reserved.
//

import Foundation

let payPalLiveApiString = "https://api.paypal.com/v1/payments/payment/PAY-NONETWORKPAYIDEXAMPLE123"

let payPalSandBoxApiCURL = "https://api.sandbox.paypal.com/v1/payments/payment/PAY-5YK922393D847794YKER7MUI"


class payPalResData {
    //private var _environment: String!
    private var _createTime: NSDate!
    private var _id: String!
    private var _state: String!
    
    var createTime: NSDate {
        return _createTime
    }
    
    var id: String {
        return _id
    }
    
    var state: String {
        return _state
    }
    
    init( createTime: NSDate, id: String, state: String) {
        _createTime = createTime
        _id = id
        _state = state
    }
    
}