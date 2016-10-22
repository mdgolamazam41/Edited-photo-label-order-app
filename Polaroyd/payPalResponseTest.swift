//
//  payPalResponseTest.swift
//  Wedding Shot
//
//  Created by USER on 10/15/16.
//  Copyright © 2016 FV iMAGINATION. All rights reserved.
//

import UIKit

class payPalResponseTest: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let session = NSURLSession.sharedSession()
//        let url1 = NSURL(string: payPalLiveApiString)!
//        
//        session.dataTaskWithURL(url1) { (data: NSData?, response:NSURLResponse?, error: NSError?) -> Void in
//            
//            if let responseData = data {
//                do {
//                    let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
//                    
//                    if let dict = json as? Dictionary<String, AnyObject> {
//                        if let createTime = dict["create_time"] as? NSDate, let paymentID = dict["id"] as? String, let pState = dict["state"] as? String {
//                            let payPalResponse = payPalResData(createTime: createTime, id: paymentID, state: pState)
//                            
//                            print(payPalResponse.id)
//                            print(payPalResponse.createTime)
//                            print(payPalResponse.state)
//                            
//                        }
//                    }
//                }catch {
//                    print("Could not serialize")
//                }
//            }
//        }.resume()
    
    }
}
