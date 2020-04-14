//
//  ViewController.swift
//  SiliconOrcInterview
//
//  Created by Nirob Hasan on 13/4/20.
//  Copyright © 2020 Nirob Hasan. All rights reserved.
//

import UIKit
import SwiftyJSON
import HealthKit
import CoreMotion

class ViewController: BaseViewController {
    @IBOutlet weak var nhNavigationBar: NHNavigationBar!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var distanceCoveredLabel: UILabel!
    @IBOutlet weak var timeSpentLabel: UILabel!
    @IBOutlet weak var validityLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    var seconds = 0 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    
        
    let pedometer = CMPedometer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nhNavigationBar.navDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.setupNavBar()
        
        self.latitudeLabel.text = "Latitude: \(NHLocationManager.shared.location?.coordinate.latitude ?? 0)"
        self.longitudeLabel.text = "Longitude: \(NHLocationManager.shared.location?.coordinate.longitude ?? 0)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    func setupNavBar() {
        nhNavigationBar.setTitleLabel(title: "Step Validation")
    }

    @IBAction func startButtonClicked(_ sender: Any) {
        let button = sender as! UIButton
        if button.tag == 1 { // click on start button
            button.tag = 2
            button.setTitle("Stop", for: .normal)
            self.startTimerRunningFunctionalies()
        }
        else if button.tag == 2 { //click on stop button
            button.tag = 1
            button.setTitle("Start", for: .normal)
            self.stopTimer()
        }
    }
    
    func startTimerRunningFunctionalies() {
        if NHLocationManager.shared.isNotDeterminedLocation() {
           NHLocationManager.shared.setupLocationManager()
        }
        self.motionPermission()
        self.runTimer()
    }
    
    func healthPermission() {
        let heartRateType:HKQuantityType   = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!

        HKHealthStore().requestAuthorization(toShare: nil, read: [heartRateType]) {(success, error) in
            print(success)
            //Success will always be equal to true unless a genuine error occurs
        }
    }
    
    func motionPermission() {
        if CMPedometer.isStepCountingAvailable() {
            let calendar = Calendar.current
            pedometer.queryPedometerData(from: calendar.startOfDay(for: Date()), to: Date()) { (data, error) in
                print(data)
            }
        }
    }
    
    func runTimer() {
        isTimerRunning = true
         timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds += 1     //This will decrement(count down)the seconds.
        timerLabel.text = self.secondsToHoursMinutesSecondsString(seconds: seconds) //This will update the label.
    }
    
    func stopTimer() {
        timer.invalidate()
        self.isTimerRunning = false
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func secondsToHoursMinutesSecondsString(seconds: Int) -> String {
        let (h,m,s) = self.secondsToHoursMinutesSeconds(seconds: seconds)
        return "\(String(format: "%02d", h)):\(String(format: "%02d", m)):\(String(format: "%02d", s))"
    }
}

extension ViewController: NHNavigationBarDelegate {
    func backButtonClicked() {
        
    }
    
    func rightButtonClicked() {
        
    }
    
}

