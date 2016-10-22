//
//  cartViewController.swift
//  Wedding Shot
//
//  Created by Ashraf Ul Alam Tusher on 1/10/16.
//  Copyright © 2016 FV iMAGINATION. All rights reserved.
//

import UIKit
import Parse
import Foundation


extension UInt {
    /// SwiftExtensionKit
    var toInt: Int { return Int(self) }
}
var totaluserBillMe: Double = 0
class cartViewController: UIViewController,PayPalPaymentDelegate {

    @IBOutlet weak var numberOFShotsCart: UILabel!
    
    
    @IBOutlet weak var numberOfOrininalShots: UILabel!
    
    
    @IBOutlet weak var shotTotal: UILabel!
    
    
    @IBOutlet weak var shotShipping: UILabel!
    
    
    @IBOutlet weak var subTotal: UILabel!
    
    
    @IBOutlet weak var userName: UITextField!
    
    
    @IBOutlet weak var userEmail: UITextField!
    
    
    @IBOutlet weak var userAddress1: UITextField!
    
    
    @IBOutlet weak var userAddress2: UITextField!
   
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    
    var payPalConfig = PayPalConfiguration()
    
    var environment:String = PayPalEnvironmentSandbox {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnectWithEnvironment(newEnvironment)
            }
        }
    }
    
    var acceptCreditCards: Bool = true {
        didSet {
            payPalConfig.acceptCreditCards = acceptCreditCards
        }
    }
    

    
    @IBAction func payAndSendDataToServer(sender: AnyObject) {
        activityView.hidden = false
        
        
        if userName.text == "" || userEmail.text == "" || userAddress1.text == "" {
            
            
            
            let alertController = UIAlertController(title: "Cant confirm", message: "Please filled out all the required fields", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Try Again", style: .Cancel) { (action) in
                // ...
            }
            alertController.addAction(cancelAction)
            
            self.presentViewController(alertController, animated: true) {
                // ...
            }
        
        
        
        
        }else{
        
            activityView.startAnimating()
            
            var order = PFObject(className:"capOrder")
            order["userName"] = userName.text
            order["userEmail"] = userEmail.text
            order["userAdd1"] = userAddress1.text
            order["userAdd2"] = userAddress2.text
            let imageData = UIImagePNGRepresentation(finalImage!)
            let imageFile = PFFile(name: "profilePhoto.png", data: imageData!)
            order["labelPhoto"] = imageFile
            order["numberOfBottle"] = numberOfGlassShot
            order["capName"] = selectedCapId
            print(totaluserBillMe)
            order["totalBill"] = totaluserBillMe
            // order["userTotalBillme"] = totaluserBillMe
            
            
            // Process Payment once the pay button is clicked.
            
            let item1 = PayPalItem(name: String(userName.text), withQuantity: UInt(numberOfGlassShot), withPrice: NSDecimalNumber(string: "1.25"), withCurrency: "USD", withSku: "g-azam-0001")
            
            let items = [item1]
            let subtotal = PayPalItem.totalPriceForItems(items)
            
            // Optional: include payment details
            let shipping = NSDecimalNumber(string: "4.49")
            let tax = NSDecimalNumber(string: "0.00")
            let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
            
            let total = subtotal.decimalNumberByAdding(shipping).decimalNumberByAdding(tax)
            
            let payment = PayPalPayment(amount: total, currencyCode: "USD", shortDescription: String(userName.text!), intent: .Sale)
            
            payment.items = items
            payment.paymentDetails = paymentDetails
            
            if (payment.processable) {
                
                let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
                presentViewController(paymentViewController, animated: true, completion: nil)
            }
            else {
                
                print("Payment not processalbe: \(payment)")
            }

            
            order.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                    self.performSegueWithIdentifier("successPage", sender: self)
                } else {
                    // There was a problem, check error.description
                    print("no")
                    print("erro.description")
                }
            }
            
            


        
        }
 
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        activityView.hidden = true
        numberOfOrininalShots.text = String(numberOfGlassShot)
        
        let ShotTotalPriceInt = (Double(numberOfGlassShot)) * 1.25
        
        print(ShotTotalPriceInt)
        
        shotTotal.text = String(ShotTotalPriceInt)
        
        totaluserBillMe = ShotTotalPriceInt + 4.49
        
        subTotal.text = String(totaluserBillMe)
        
        print(totaluserBillMe)
        
        
        //PayPal Mobile configuration
        payPalConfig.acceptCreditCards = acceptCreditCards;
        payPalConfig.merchantName = "Artin Sahakian"
        payPalConfig.merchantPrivacyPolicyURL = NSURL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = NSURL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        payPalConfig.languageOrLocale = NSLocale.preferredLanguages()[0] as! String
        payPalConfig.payPalShippingAddressOption = .PayPal;
        
        PayPalMobile.preconnectWithEnvironment(environment)
        

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // PayPalPaymentDelegate
    
    func payPalPaymentDidCancel(paymentViewController: PayPalPaymentViewController!) {
        print("PayPal Payment Cancelled")
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func payPalPaymentViewController(paymentViewController: PayPalPaymentViewController!, didCompletePayment completedPayment: PayPalPayment!) {
        
        print("PayPal Payment Success !")
        paymentViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            // send completed confirmaion to your server
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
