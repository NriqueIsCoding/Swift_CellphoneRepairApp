//  PROGRAMMER: Enrique Estacio, Ralph Martin
//  PANTHERID: 4114298
//  CLASS:          COP 465501 TR 5:00
//  INSTRUCTOR:     Steve Luis  ECS 235
//  ASSIGNMENT:     FInal Project
//  DUE:            Thursday 03/27/2017
//


import Foundation
import UIKit
import CoreData

class AccountTVC: UITableViewController {

    var customer:Customer?
    
    let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    //creating array of customer thats gonna hold data
    var customers = [Customer]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    override func viewWillAppear(animated: Bool) {
        
        if customer?.date == nil{
            confMessage("Attention")
            
        }
        print(customer)
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell  = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        //configuring the cell
        cell.textLabel?.text = customer?.date
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      
//        mod = model[indexPath.row]
//        
//        print(mod + " selected")
//        
//        customer?.deviceModel = mod
//        
//        //saveToCoreData()
//        
//        confMessage(mod)
        
    }

    func confMessage(screenMessage: String){
        //Display confirmation Message
        let myAlert = UIAlertController(title: screenMessage, message:"You have no appointments at the moment. Press OK to continue", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style:UIAlertActionStyle.Default){
            action in self.dismissViewControllerAnimated(true, completion: nil)
        }
        myAlert.addAction(okAction)
        //self.presentViewController(myAlert, animated: true, completion: nil)
        self.parentViewController?.presentViewController(myAlert, animated: true, completion: nil)

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showDevices"{
            
            let detailViewController = segue.destinationViewController as! SelectDeviceViewController
            detailViewController.customer = customer
            
        }
    }
}