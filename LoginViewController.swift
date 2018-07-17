//  PROGRAMMER: Enrique Estacio
//  PANTHERID: 4114298
//  CLASS:          COP 465501 TR 5:00
//  INSTRUCTOR:     Steve Luis  ECS 235
//  ASSIGNMENT:     FInal Project
//  DUE:            Thursday 03/27/2017
//

import Foundation
import UIKit
import CoreData

class LoginViewController: UIViewController{
    
    
    var currentIndex = 0
    
    let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    //creating array of customer thats gonna hold data
    var customers = [Customer]()
    
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    override func viewWillAppear(animated: Bool) {
        
        let request = NSFetchRequest(entityName: "Customer")
        
        do{
        try customers = moContext.executeFetchRequest(request) as! [Customer]
        }catch{
        print("Data could not be Fetched")
        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        usernameTextField.text = ""
        passwordTextField.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loginErrorMessage(){
    
        let alertController = UIAlertController(title: "Username or password cannot be blank", message:
            "Please try again", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func dataNotFoundErrorMessage(){
        let alertController = UIAlertController(title: "Check your username or password", message:
            "if you don't have an account with us, Please register", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    
    }
    
    func findCustomer() -> Int{
    
        for i in 0...customers.count - 1{
            if customers[i].username == usernameTextField.text{
                currentIndex = i
            }
        }
    return currentIndex
            
    
    }
    
    @IBAction func LoginButtonTapped(sender: UIButton) {
    
        if usernameTextField.text != "" && passwordTextField.text != ""{
            
            if customers.count != 0{
                findCustomer()
            
                if customers[currentIndex].username != usernameTextField.text || customers[currentIndex].password != passwordTextField.text{
                        dataNotFoundErrorMessage()
                }else{
                        print("Access Granted")
                        print(customers[currentIndex].firstName)
                        self.performSegueWithIdentifier("showAccount", sender: self)
                    }
            }else{
                dataNotFoundErrorMessage()
            }
        }
        else{
            loginErrorMessage()
       
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showAccount"{
        
        let detailViewController = segue.destinationViewController as! AccountTVC   
            detailViewController.customer = customers[currentIndex]
        
        }
    }
    
    @IBAction func hideKeyBoard(sender: AnyObject){
        
        for v in self.view.subviews{
            
            if v.isKindOfClass(UITextField){
                v.resignFirstResponder()
            }
            
        }
    }
    
}










