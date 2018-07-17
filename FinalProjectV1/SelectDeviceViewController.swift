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

class SelectDeviceViewController: UITableViewController{

    var androidTapped: String = ""
    var appleTapped: String = ""
    
    var customer:Customer?
    
    let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    //creating array of customer thats gonna hold data
    var customers = [Customer]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        print(customer)
        
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0{
            customer?.deviceType = "Android"
        
            //Confirmation Purposes
            androidTapped = (customer?.deviceType)!
            
            //Saving Data
            saveToCoreData()
         
            //Testing Purposes
            print("androidTapped")
            
            confMessage(androidTapped)
        
        }
        
        if indexPath.row == 1{
            
            customer?.deviceType = "Iphone"
            
            //Confirmation Purposes
            appleTapped = (customer?.deviceType)!

            //Saving Data
            saveToCoreData()
            
            //Testing Purposes
            print("iPhoneTapped")
            
            confMessage(appleTapped)
        }
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
        
        if segue.identifier == "showAndroidDevices"{
            
            let destination = segue.destinationViewController as! AndroidDevicesTVC
            destination.customer = customer
        }
        
        if segue.identifier == "showIphoneDevices"{
            
            let destination = segue.destinationViewController as! IphoneDevicesTVC
            destination.customer = customer
        }
    }
    
    func confMessage(screenMessage: String){
        //Display confirmation Message
        let myAlert = UIAlertController(title:screenMessage, message:"Device Selected. Press Ok to continue", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style:UIAlertActionStyle.Default){
            action in self.dismissViewControllerAnimated(true, completion: nil)
        }
        myAlert.addAction(okAction)
        //self.presentViewController(myAlert, animated: true, completion: nil)
        self.parentViewController?.presentViewController(myAlert, animated: true, completion: nil)
    }


}
