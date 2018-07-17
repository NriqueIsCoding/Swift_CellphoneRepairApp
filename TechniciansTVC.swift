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

class TechniciansTVC: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate, UISearchResultsUpdating{
    
    var name: String = ""
    
    var customer:Customer?
    
    let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    //creating array of customer thats gonna hold data
    var customers = [Customer]()
    
    var nameTehcnician:[String] = ["Carlos", "Mike", "Sofia", "Rebeca", "Rick", "Jamal", "Steven", "stacy", "Bill", "Enrique", "Estevan"]
    let citytechnician: [String] = ["Miami", "Broward", "Miami Beach", "North Miami Beach", "Miami Gardens", "Hialeah", "Hialeah Gardens", "Broward", "Hollywood", "Coconut Grove", "Opa locka"]
    
    var FilteredNames:[String] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //testing purposes
        print(customer)
        // Do any additional setup after loading the view, typically from a nib.
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.tableView.tableHeaderView=searchController.searchBar
        
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.active &&  searchController.searchBar != ""{
            
            return self.FilteredNames.count
            
        }else{
            
            return nameTehcnician.count
            
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        if searchController.active &&  searchController.searchBar != ""{
            
            cell.textLabel?.text = self.FilteredNames[indexPath.row]
        
            
            
        }else{
            let name = nameTehcnician[indexPath.row]
            let city = citytechnician[indexPath.row]
        
            //configuring the cell
            cell.textLabel?.text = name
            cell.detailTextLabel?.text = city
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if searchController.active &&  searchController.searchBar != ""{
            
            name = FilteredNames[indexPath.row]
            
            print(name + " selected")
            
            customer?.technicianName = name
            
            saveToCoreData()
            
            //confMessage()
            //testing
            print(customer)
            
        }else{
            
            name = nameTehcnician[indexPath.row]
            
            print(name + " selected")
            
            customer?.technicianName = name
            
            saveToCoreData()
            
            //confMessage()
            //testing
            print(customer)

        }
        
    }
    
    func filterContentForSearch(searchString: String){
        
        self.FilteredNames = self.nameTehcnician.filter(){nil != $0.rangeOfString(searchString)}
        self.tableView.reloadData()
        }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.filterContentForSearch(searchController.searchBar.text!)
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
        
        if segue.identifier == "showIPhoneIssue"{
            
            let destination = segue.destinationViewController as! SelectIssueViewController
            destination.customer = customer
        }
        
    }
    
    func confMessage(){
        //Display confirmation Message
        let myAlert = UIAlertController(title: "Model Selected", message: name + ". Press Ok to Select Issue", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style:UIAlertActionStyle.Default){
            action in self.dismissViewControllerAnimated(true, completion: nil)
        }
        myAlert.addAction(okAction)
        //self.presentViewController(myAlert, animated: true, completion: nil)
        self.parentViewController?.presentViewController(myAlert, animated: true, completion: nil)
    }

    
    


}
