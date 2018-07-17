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

class RegisterViewController: UIViewController, NSFetchedResultsControllerDelegate{

    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    
    let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackToLogin(sender: UIButton) {
        self.navigationController!.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func RegisterButtonTapped(sender: UIButton) {
        
        //get Description of Entity
        let customerDescription = NSEntityDescription.entityForName("Customer", inManagedObjectContext: moContext)
        
        //We create the managed object to be inserted into the core data
        let customer = Customer(entity: customerDescription!, insertIntoManagedObjectContext: moContext)
    
        //set the attributes
        let firstName = firstNameTextField.text
        let lastName = lastNameTextField.text
        let email = emailTextField.text
        let username = usernameTextField.text
        let password = passwordTextField.text
        let confirmPassword = confirmPasswordTextField.text
        
        
        //if decided to have image
        
//        let dImage = UIImage(named: "phone.jpeg")
//        let imgData = UIImageJPEGRepresentation(dImage!, 1)
        
        
        //check for empty fields
        if (firstName == "" || lastName == "" || email == "" || username == "" || password == "" || confirmPassword == ""){
            
            //display alert message
            displayAlertMessage("All fields are required")
            
        }
        //check if password matches
        if(password != confirmPassword){
            //display alert message
            displayAlertMessage("Passwords do not match")
        }
    
        customer.firstName = firstName
        customer.lastName = lastName
        customer.email = email
        customer.username = username
        customer.password = password
        customer.confirmedPassword = confirmPassword
        
        //store Image
        //customer.devicePicture = imgData
        
        // Save the context
        saveToCoreData()
        
    }
    
    func saveToCoreData(){
        
        do {
           try moContext.save()
            print("Customer saved to CoreData")
            //Display confirmation Message
            let myAlert = UIAlertController(title: "Thank you", message: "Registration Completed", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "Ok", style:UIAlertActionStyle.Default){
                action in self.dismissViewControllerAnimated(true, completion: nil)
                self.navigationController!.popToRootViewControllerAnimated(true)
            }
            myAlert.addAction(okAction)
            self.presentViewController(myAlert, animated: true, completion: nil)
            
        } catch {
            
            print("Could not save Data to CoreData")
        }

    }
    
    func displayAlertMessage(UserMessage: String){
        let myAlert = UIAlertController(title: "Alert", message: UserMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style:UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    
    }
    
    @IBAction func hideKeyBoard(sender: AnyObject){
    
        for v in self.view.subviews{
        
            if v.isKindOfClass(UITextField){
            v.resignFirstResponder()
            }
        
        }
    }
    
    
    
    
}