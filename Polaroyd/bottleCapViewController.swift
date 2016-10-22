//
//  bottleCapViewController.swift
//  Wedding Shot
//
//  Created by Ashraf Ul Alam Tusher on 1/8/16.
//  Copyright © 2016 FV iMAGINATION. All rights reserved.
//

import UIKit
import Parse


var selectedCapId: String = ""
var selectedCapImageUser = UIImage()




class bottleCapViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var capName = [String]()
    var capPrice = [Int]()
    var capImage = [PFFile]()
    var capDes = [String]()
    var capId = [Int]()
    var capSelectedID:Int = 0
    
    @IBOutlet weak var dataTable: UITableView!
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var query = PFQuery(className:"Cap")
        // query.whereKey("playerName", equalTo:"Sean Plott")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        // print(object["CapName"])
                        self.capName.append(object["CapName"] as! String)
                        print(object["BottleDescription"])
                        self.capDes.append(object["BottleDescription"] as! String)
                        self.capImage.append(object["capImage"] as! PFFile)
                        let capID = object["CapID"] as! Int
                        self.capId.append(capID)
                        print(self.capName)
                        self.dataTable.reloadData()
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return capName.count
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    
        
        
        
        cell.textLabel?.text = capName[indexPath.row]
        //var capPriceToString = String(capPrice[indexPath.row])
        cell.detailTextLabel?.text = capDes[indexPath.row]
        var capSelectedID = capName[indexPath.row]
        capImage[indexPath.row].getDataInBackgroundWithBlock {
            (imageData: NSData?, error:NSError?) -> Void in
            
            if error == nil {
                
                let image = UIImage(data: imageData!)
                cell.imageView?.image = image
                
            }
        }
        
        
        // cell.imageView?.image = UIImage(named: "logo")
        
    // Configure the cell...
    
    return cell
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        selectedCapId = ((cell?.textLabel?.text))!!
        selectedCapImageUser = (cell?.imageView?.image)!
        // otherProfileName = cell.profileNameLbl.text!
        self.performSegueWithIdentifier("capTocart", sender: self)
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */

    
    
    
    
    
    
    

}
