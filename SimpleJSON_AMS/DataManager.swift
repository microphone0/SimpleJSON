//
//  DataManager.swift
//  SimpleJSON_AMS
//
//  Created by Adam Saxton on 3/4/19.
//  Copyright © 2019 Adam Saxton. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
    let MYJSONSTRING = "https://api.myjson.com/bins/8lf8u"
    
    var dataArray = ["Unexpected Data in bagging area!!"]
    
    func getData(completion: @escaping(_ success: Bool) -> ()) {
        
        var success = true
        
        let actualUrl = URL(string: MYJSONSTRING)
        
        let task = URLSession.shared.dataTask(with: actualUrl!) { (data, response, error) in
            
            if let _ = data, error == nil {
                if let jsonObj = try?
                    JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                    if let veggieArray = jsonObj!.value(forKey: "characters") as? Array<String> {
                        self.dataArray = veggieArray
                        
                        //printing the json in console
                        print(jsonObj!.value(forKey: "characters")!)
                    }
                }
            } else {
            // we had an error or the data didn't come back
            success = false
            }
            completion(success)
        }
        task.resume()
        
    }
}
