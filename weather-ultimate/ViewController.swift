//
//  ViewController.swift
//  weather-ultimate
//
//  Created by Mike Piatin on 6/05/2016.
//  Copyright © 2016 Aurora Software. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var tempMin: UILabel!
    @IBOutlet weak var tempMax: UILabel!
    @IBOutlet weak var citiName: UILabel!
    
    var weather: Weather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weather = Weather(id: CITI_ID, name: CITI_NAME)
        
        weather.downloadWeatherDetails {
            self.updateUI()
        }
    }
    
    func updateUI() {
        citiName.text = "City of \(weather.citiName)"
        tempMin.text = "\(weather.tempMin)˚"
        tempMax.text = "\(weather.tempMax)˚"
        tempLbl.text = "\(weather.temp)˚"
    }




}

