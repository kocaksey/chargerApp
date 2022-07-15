//
//  ViewController.swift
//  chargerApp
//
//  Created by Seyhun Koçak on 12.07.2022.
//

import UIKit
import CoreLocation
import Alamofire

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
        
        
        
        // BVG4QyVeCQUHcOpEMxKderIMuTizQrfD
    

}
    @IBAction func loginButton(_ sender: Any) {
        let url = URL(string: "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/auth/login")!
                var request = URLRequest(url: url)
                
              
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")

                let parameters: [String: Any] = [
                    "email" : textField.text,
                    "deviceUDID" : String(UIDevice.current.identifierForVendor!.uuidString),
                    
                ]

                request.httpBody = try! JSONSerialization.data(withJSONObject: parameters)

               
                 AF.request(request)
                    .responseDecodable(of: User.self) { (response) in
                       guard let result = response.value else { return }
                        print(result.email)
                        print(result.userID)
                        print(result.token)
                        
                     }
    }
}

