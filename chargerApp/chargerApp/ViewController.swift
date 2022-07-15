//
//  ViewController.swift
//  chargerApp
//
//  Created by Seyhun Koçak on 12.07.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UNUserNotificationCenterDelegate {
    
    
    
    @IBOutlet weak var fieldView: UIView!
    @IBOutlet weak var textField: UITextField!{
        didSet {
            let placeholderText = NSAttributedString(string: "E-POSTA GİR",
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 183.0/255.0, green: 189.0/255.0, blue: 203.0/255.0, alpha: 1.0)])
            
            textField.attributedPlaceholder = placeholderText
        }
    }
    var locationManager = CLLocationManager()
    let center = UNUserNotificationCenter.current()


    override func viewDidLoad() {
        super.viewDidLoad()
        postRequest(url: "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/auth/login", parameters: ["email": "seyhunkocak11@gmail.com", "deviceUDID": String(UIDevice.current.identifierForVendor!.uuidString)], token: nil)

        
        let thickness: CGFloat = 2.0
                let bottomBorder = CALayer()
                bottomBorder.frame = CGRect(x:0, y: self.fieldView.frame.size.height - thickness, width: self.fieldView.frame.size.width, height:thickness)
                bottomBorder.backgroundColor = UIColor(red: 183.0/255.0, green: 189.0/255.0, blue: 203.0/255.0, alpha: 1.0).cgColor
                fieldView.layer.addSublayer(bottomBorder)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            if let error = error {
                // Handle the error here.
            }
            
            // Enable or disable features based on the authorization.
        }
        
        
        print(UIDevice.current.identifierForVendor!.uuidString)
        
        // BVG4QyVeCQUHcOpEMxKderIMuTizQrfD
    
        func postRequest(url : String , parameters: [String: Any] , token : String?) {
            let parameters = parameters
          
          // create the url with URL
          let url = URL(string: url)!
            
          // create the session object
          let session = URLSession.shared
          
          // now create the URLRequest object using the url object
          var request = URLRequest(url: url)
          request.httpMethod = "POST" //set http method as POST
          
          // add headers for the request
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type") // change as per server requirements
            if token != nil {
                request.addValue("\(token)", forHTTPHeaderField: "token")
            }
          
          do {
            // convert parameters to Data and assign dictionary to httpBody of request
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
          } catch let error {
            print(error.localizedDescription)
              return
          }
          
          // create dataTask using the session object to send data to the server
            let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
              print("Post Request Error: \(error.localizedDescription)")
              return
            }
            
            
            // ensure there is data returned
            guard let responseData = data else {
              print("nil Data received from the server")
              return
            }
              
            do {
              // create json object from data or use JSONDecoder to convert to Model stuct
                
                
                if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
                    
                    
                    
                print(jsonResponse)
                // handle json response
                    
                    
              } else {
                print("data maybe corrupted or in wrong format")
                throw URLError(.badServerResponse)
              }
                
            
            }
              catch let error {
              print(error.localizedDescription)
            }
              
          }
          // perform the task
          task.resume()
            
        }

}
}

