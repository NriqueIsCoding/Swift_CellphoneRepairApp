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


class AndroidDevicesTVC: UITableViewController{
    
    var mod = ""

    var customer:Customer?
    
    let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    //creating array of customer thats gonna hold data
    var customers = [Customer]()
    
    var brand: String = "Samsung"
    
    var model:[String] = ["Galaxy S4", "Galaxy S5", "Galaxy s6", "Galaxy s7", "Galaxy Note 4", "Galaxy Note 5"]
    
    let imgData = [UIImageJPEGRepresentation(UIImage(named: "galaxy s4.jpeg")!, 1), UIImageJPEGRepresentation(UIImage(named: "galaxy s5.jpeg")!, 1), UIImageJPEGRepresentation(UIImage(named: "galaxyS6.jpeg")!, 1), UIImageJPEGRepresentation(UIImage(named: "galaxy s7.jpeg")!, 1), UIImageJPEGRepresentation(UIImage(named: "galaxy note 4.jpeg")!, 1), UIImageJPEGRepresentation(UIImage(named: "galaxy note 5.jpeg")!, 1)]
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        let mod = model[indexPath.row]
        let img = imgData[indexPath.row]
        
        //configuring the cell
        cell.textLabel?.text = brand
        cell.detailTextLabel?.text = mod
        cell.imageView?.image = UIImage(data: img!)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        mod = model[indexPath.row]
        
        print(mod + " selected")
        
        customer?.deviceModel = mod
        
        saveToCoreData()
        
        confMessage(mod)
        
    }
    
    func saveToCoreData(){
        
        do {
            try moContext.save()
            print("Customer saved to CoreData")
            
            
        } catch {
            
            print("Could not save Data to CoreData")
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showAndroidIssue"{
            
            let destination = segue.destinationViewController as! SelectIssueViewController
            destination.customer = customer
            
        }
        
    }
    
    func confMessage(screenMessage: String){
        //Display confirmation Message
        let myAlert = UIAlertController(title:screenMessage, message:"Model Selected. Press Ok to continue", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style:UIAlertActionStyle.Default){
            action in self.dismissViewControllerAnimated(true, completion: nil)
        }
        myAlert.addAction(okAction)
        //self.presentViewController(myAlert, animated: true, completion: nil)
        self.parentViewController?.presentViewController(myAlert, animated: true, completion: nil)
    }

    



}








