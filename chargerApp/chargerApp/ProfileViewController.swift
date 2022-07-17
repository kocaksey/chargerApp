//
//  ProfileViewController.swift
//  chargerApp
//
//  Created by Seyhun Koçak on 17.07.2022.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController {

    @IBOutlet weak var deviceIDLabel: UILabel!
    @IBOutlet weak var eMailLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deviceIDLabel.text = String(UIDevice.current.identifierForVendor!.uuidString)
        eMailLabel.text = email

    }
    

    @IBAction func BackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func quitButtonClicked(_ sender: Any) {
        let url = URL(string: "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/auth/logout/\(userID!)")!
                var request = URLRequest(url: url)
                
              
                request.httpMethod = "POST"

        let headers : HTTPHeaders = ["token" : token!, "Accept" : "application/json"]
        request.headers = headers

        AF.request(request)
                    .responseDecodable(of: User.self) { (response) in
                       guard let result = response.value else { return }
                        print(result)
                        
                        
                     }

        
    }
    
}
