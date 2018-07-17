

//  PROGRAMMER: Enrique Estacio
//  PANTHERID: 4114298
//  CLASS:          COP 465501 TR 5:00
//  INSTRUCTOR:     Steve Luis  ECS 235
//  ASSIGNMENT:     FInal Project
//  DUE:            Thursday 03/27/2017
//
import Foundation
import CoreData

extension Customer {

    @NSManaged var confirmedPassword: String?
    @NSManaged var email: String?
    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var username: String?
    @NSManaged var password: String?
    @NSManaged var deviceType: String?
    @NSManaged var deviceModel: String?
    @NSManaged var deviceIssue: String?
    @NSManaged var devicePicture: NSData?
    @NSManaged var technicianName: String?
    @NSManaged var date: String?
    

}
