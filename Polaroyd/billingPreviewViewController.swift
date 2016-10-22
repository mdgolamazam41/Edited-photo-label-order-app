//
//  billingPreviewViewController.swift
//  Wedding Shot
//
//  Created by Ashraf Ul Alam Tusher on 1/8/16.
//  Copyright © 2016 FV iMAGINATION. All rights reserved.
//

import UIKit
import Parse

var numberOfGlassShot: Int = 0

class billingPreviewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        finalProduct.image = finalImage
        // selectedCapName.text = selectedCapId
        // Do any additional setup after loading the view.
        print("ME")
        print(selectedCapId)
        //selectedCapImageuserF.image = selectedCapImageUser
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
    @IBOutlet weak var numGlassOrder: UITextField!
    
    @IBOutlet weak var finalProduct: UIImageView!
    
    
    @IBOutlet weak var selectedCapImageuserF: UIImageView!

    
    @IBAction func placeOrder(sender: AnyObject) {
        
       
        
        if numGlassOrder.text == "" {
            
            
            let alertController = UIAlertController(title: "Cant confirm", message: "Please select the Number of shot bottle you want", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Try Again", style: .Cancel) { (action) in
                // ...
            }
            alertController.addAction(cancelAction)
            
            self.presentViewController(alertController, animated: true) {
                // ...
            }

        
        }else{
        
            numberOfGlassShot = Int(numGlassOrder.text!)!
            self.performSegueWithIdentifier("productViewTOfinal", sender: self)
            
            
        }
        
        
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
