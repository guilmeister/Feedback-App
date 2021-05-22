//
//  DatabaseHelper.swift
//  Feedback App
//
//  Created by Edward Guilllermo on 4/25/21.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper {
    
    static var inst = DatabaseHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func signUpButtonClicked(object : [String : String]) {
        //Function that saves the username and password of a Customer
        let customer = NSEntityDescription.insertNewObject(forEntityName: "Customer", into: context!) as! Customer
        customer.username = object["username"]
        customer.password = object["password"]
        do {
            try context?.save()
            print("Sign Up Successful")
        }
        catch {
            print("Sign Up Failed")
        }
    }
    
    func endRoomSurvey(username : String, roomScore : Float) {
        //Function that saves the user's score for the Room Survey
        var customer = Customer()
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Customer")
        fetchReq.predicate = NSPredicate(format: "username == %@", username)
        do {
            let cust = try context?.fetch(fetchReq)
            if (cust?.count != 0) {
                customer = cust?.first as! Customer
                customer.roomScore = roomScore
                try context?.save()
                print("Data: roomScore Updated")
            }
        }
        catch {
            print("Error")
        }
    }
    
    func endGymSurvey(username : String, gymScore : Float) {
        //Function that saves the user's score for the Gym Survey
        var customer = Customer()
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Customer")
        fetchReq.predicate = NSPredicate(format: "username == %@", username)
        do {
            let cust = try context?.fetch(fetchReq)
            if (cust?.count != 0) {
                customer = cust?.first as! Customer
                customer.gymScore = gymScore
                try context?.save()
                print("Data: gymScore Updated")
            }
        }
        catch {
            print("Error")
        }
    }
    
    func endFoodSurvey(username : String, foodScore : Float) {
        //Function that saves the user's score for the Food Survey
        var customer = Customer()
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Customer")
        fetchReq.predicate = NSPredicate(format: "username == %@", username)
        do {
            let cust = try context?.fetch(fetchReq)
            if (cust?.count != 0) {
                customer = cust?.first as! Customer
                customer.foodScore = foodScore
                try context?.save()
                print("Data: foodScore Updated")
            }
        }
        catch {
            print("Error")
        }
    }
    
    func endSpaSurvey(username : String, spaScore : Float) {
        //Function that saves the user's score for the Spa Survey
        var customer = Customer()
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Customer")
        fetchReq.predicate = NSPredicate(format: "username == %@", username)
        do {
            let cust = try context?.fetch(fetchReq)
            if (cust?.count != 0) {
                customer = cust?.first as! Customer
                customer.spaScore = spaScore
                try context?.save()
                print("Data: spaScore Updated")
            }
        }
        catch {
            print("Error")
        }
    }
    
    func endOverallSurvey(username : String, overallScore : Float) {
        //Function that saves the user's score for the Overall Survey
        var customer = Customer()
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Customer")
        fetchReq.predicate = NSPredicate(format: "username == %@", username)
        do {
            let cust = try context?.fetch(fetchReq)
            if (cust?.count != 0) {
                customer = cust?.first as! Customer
                customer.overallScore = overallScore
                try context?.save()
                print("Data: overallScore Updated")
            }
        }
        catch {
            print("Error")
        }
    }
    
    func fetchData() -> [Customer] {
        //Function that fetches all Customer objects currently saved in Core Data
        var customer = [Customer]()
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Customer")
        do {
            customer = try context?.fetch(fetchReq) as! [Customer]
            print("Data Fetched")
        }
        catch {
            print("Cannot Fetch Data")
        }
        return customer
    }
    
    func resetPass(object: [String : String]) {
        //Function that resets the password of a given username
        var customer = Customer()
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Customer")
        fetchReq.predicate = NSPredicate(format: "username == %@", object["username"]!)
        do {
            let cust = try context?.fetch(fetchReq)
            if (cust?.count != 0) {
                customer = cust?.first as! Customer
                customer.password = object["password"]
                try context?.save()
                print("Data Updated")
            }
        }
        catch {
            print("Error")
        }
    }
    
    func fetchUsernameSpecifiedData (username : String) -> Customer {
        //Function that fetches a specific Customer object from a given username
        var cust = Customer()
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Customer")
        fetchReq.predicate = NSPredicate(format: "username == %@", username)
        fetchReq.fetchLimit = 1
        do {
            let req = try context?.fetch(fetchReq) as! [Customer]
            if(req.count != 0) {
                cust = req.first as! Customer
            }
            else {
                print("Data not Found")
            }
        }
        catch {
            print("Cannot fetch data")
        }
        return cust
    }
    
    func deleteData(username: String) {
        //Function that deletes the Customer object from a given a username
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Customer")
        fetchReq.predicate = NSPredicate(format: "username == %@", username)
        do {
            let st = try context?.fetch(fetchReq)
            context?.delete(st?.first as! Customer)
            try context?.save()
            print("Data Deleted")
        }
        catch {
            print("Data not Deleted")
        }
    }
}

struct Question {
    var text : String
    let choice : [Choice]
}

struct Choice {
    let text : String
}
