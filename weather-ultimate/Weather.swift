//
//  Weather.swift
//  weather-ultimate
//
//  Created by Mike Piatin on 6/05/2016.
//  Copyright © 2016 Aurora Software. All rights reserved.
//

import Foundation
import Alamofire

class Weather {
    
    private var _citiId: String!
    private var _citiName: String!
    private var _weatherUrl: String!
    private var _messageWeather: String!
    
    private var _temp: String!
    private var _tempMin: String!
    private var _tempMax: String!
    
    private var _tempArr = [String]()
    
    private var _date: String!
    private var _dateArr = [String]()
    
    var dateArr: [String] {
        return _dateArr
    }
    
    var date: String {
        return _date
    }
    
    var tempArr: [String] {
        return _tempArr
    }
    
    var messageWeather: String {
        return _messageWeather
    }
    
    var tempMin: String! {
        if _tempMin == nil {
            _tempMin = ""
        }
        return _tempMin
    }
    
    var tempMax: String {
        return _tempMax
    }
    
    var temp: String {
        return _temp
    }
    
    var weatherUrl: String {
        return _weatherUrl
    }
    
    var citiId: String {
        return _citiId
    }
    
    var citiName: String {
        return _citiName
    }
    
    init(id: String, name: String) {
        self._citiId = id
        self._citiName = name
        
        _weatherUrl = "\(BASE_URL)\(CITI_ID)\(END_URL)"
    }
    
    func downloadWeatherDetails(completed: DownloadComplete) {

        Alamofire.request(.GET, _weatherUrl).responseJSON { response in
            let result = response.result
            //  print(result.value.debugDescription)
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
            if let list = dict["list"] as? [Dictionary<String,AnyObject>] where list.count > 0 {
                  //  print(list.count) // total 39 instances
                    if let main = list[0]["main"] as? Dictionary<String,AnyObject> {
                        
                        if let temp = main["temp"] as? Int {
                            self._temp = "\(temp)"
                        }
                        if let temp_min = main["temp_min"] as? Int {
                            self._tempMin = "\(temp_min)"
                        }
                        if let temp_max = main["temp_max"] as? Int {
                            self._tempMax = "\(temp_max)"
                        }


                         completed() //the app returns to the view controller. download completed
                    }
                    
                    if list.count > 1 {
                        for x in 1..<list.count {
                            if let main = list[x]["main"] as? Dictionary<String, AnyObject> {
                                if let temp = main["temp"] as? Int, let date = list[x]["dt_txt"] as? String {
                                    self._temp = "\(temp)"
                                 self._date = "\(date)"
                                 self._tempArr.append("\(temp)")
                                 self._dateArr.append("\(date)")
                                    print(self._date)
                                }
                                
                            }
                        }
                }
          //  print(self._tempArr)
          //  print(self._dateArr)
//mark
                
                    
                }
                
                
                
            }
           
        }
        
       
    }
    

}