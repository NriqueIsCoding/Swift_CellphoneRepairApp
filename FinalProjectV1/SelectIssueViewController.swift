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

class SelectIssueViewController: UIViewController,UITableViewDelegate , UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate{
    
    
    var mod: String = ""
    var customer:Customer?
    var dateFormatter = NSDateFormatter()
    
    @IBOutlet var date: UITextField!
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet var myPicture: UIImageView!
    @IBOutlet var myTableView: UITableView!
    

    let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    //creating array of customer thats gonna hold data
    var customers = [Customer]()
    
    var issue: [String] = ["Broken Screen", "Faulty Camera", "Faulty Battery", "Not Charging"]
    
    let imgData = [UIImagePNGRepresentation(UIImage(named: "broken screen.png")!),
                   UIImagePNGRepresentation(UIImage(named: "broken camera.png")!),
                   UIImagePNGRepresentation(UIImage(named: "broken battery.png")!),
                   UIImagePNGRepresentation(UIImage(named: "charging issue.png")!)]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //assigning our viewController as the delegate
        myTableView.delegate = self
        //assigning our viewController as the dataSource
        myTableView.dataSource = self
        
    }
    override func viewWillAppear(animated: Bool) {
        
        print(customer)
    }
    
    override func viewWillDisappear(animated: Bool) {
        customer?.date = date.text
        saveToCoreData()
        
        //testing purposes
        print(customer)

        
    }
    
    
    @IBAction func textEditing(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.DateAndTime
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(SelectIssueViewController.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
        
        date.resignFirstResponder()
    }
    
    
       @IBAction func PressedCamera(sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
            imagePicker.allowsEditing = true
            imagePicker.cameraCaptureMode = .Photo  // or .Video
            imagePicker.modalPresentationStyle = .FullScreen
        }
        else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        date.text = dateFormatter.stringFromDate(sender.date)
        
    }

    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //saving it locally
        myPicture.image = image
        
        //loading and saving it to CoreData
        let img = image
        
        let imgData = UIImageJPEGRepresentation(img, 1)
        
        customer?.devicePicture = imgData
        
        saveToCoreData()
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issue.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        mod = issue[indexPath.row]
        let img = imgData[indexPath.row]
        
        //configuring the cell
        cell.textLabel?.text = mod
        //cell.detailTextLabel?.text = mod
        cell.imageView?.image = UIImage(data: img!)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        mod = issue[indexPath.row]
        
        print(mod + " selected")
        
        customer?.deviceIssue = mod
        
        saveToCoreData()
        
        confMessage(mod)
        
        //testing purposes
        print(customer)
        
    }
    
    func saveToCoreData(){
        
        do {
            try moContext.save()
            print("Customer saved to CoreData")
            
        } catch {
            
            print("Could not save Data to CoreData")
        }
    }
    
    func confMessage(screenMessage: String){
        //Display confirmation Message
        let myAlert = UIAlertController(title:screenMessage, message:"Isuue Selected. Press Ok to continue", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style:UIAlertActionStyle.Default){
            action in self.dismissViewControllerAnimated(true, completion: nil)
        }
        myAlert.addAction(okAction)
        //self.presentViewController(myAlert, animated: true, completion: nil)
        self.parentViewController?.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showTechnicians"{
            
            let destination = segue.destinationViewController as! TechniciansTVC    
            destination.customer = customer
            
        }
        
    }
    
    
    
    
    
}
