//
//  PayPalBillingView.swift
//  Wedding Shot
//
//  Created by USER on 10/13/16.
//  Copyright © 2016 FV iMAGINATION. All rights reserved.
//

//import Foundation
import UIKit

class PayPalBillingView: UIViewController, PayPalPaymentDelegate{
    
    // For PayPal integration, we need to follow these steps
    // 1. Add Paypal config. in AppDelegate
    // 2. Create PayPal object
    // 3. Declare payment configurations
    // 4. Implement PayPalPaymentDelegate
    // 5. Add payment items and related details
    
    
    var payPalConfig = PayPalConfiguration()
    
    var environment:String = PayPalEnvironmentNoNetwork {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        payPalConfig.acceptCreditCards = acceptCreditCards;
        payPalConfig.merchantName = "Siva Ganesh Inc."
        payPalConfig.merchantPrivacyPolicyURL = NSURL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = NSURL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        payPalConfig.languageOrLocale = NSLocale.preferredLanguages()[0] as! String
        payPalConfig.payPalShippingAddressOption = .PayPal;
        
        PayPalMobile.preconnectWithEnvironment(environment)
        
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
    
    
    
    @IBAction func payPressed(sender: AnyObject) {
        
        // Process Payment once the pay button is clicked.
        
        var item1 = PayPalItem(name: "G Azam Rakib", withQuantity: 1, withPrice: NSDecimalNumber(string: "9.99"), withCurrency: "USD", withSku: "g-azam-0001")
        
        let items = [item1]
        let subtotal = PayPalItem.totalPriceForItems(items)
        
        // Optional: include payment details
        let shipping = NSDecimalNumber(string: "0.00")
        let tax = NSDecimalNumber(string: "0.00")
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
        
        let total = subtotal.decimalNumberByAdding(shipping).decimalNumberByAdding(tax)
        
        let payment = PayPalPayment(amount: total, currencyCode: "USD", shortDescription: "G Azam Rakib", intent: .Sale)
        
        payment.items = items
        payment.paymentDetails = paymentDetails
        
        if (payment.processable) {
            
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
            presentViewController(paymentViewController, animated: true, completion: nil)
        }
        else {
            
            print("Payment not processalbe: \(payment)")
        }
        
    }
}

