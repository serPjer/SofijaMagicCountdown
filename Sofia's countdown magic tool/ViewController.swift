//
//  ViewController.swift
//  Sofia's countdown magic tool
//
//  Created by Petar Stijepcic on 7/30/19.
//  Copyright © 2019 Pi Solution. All rights reserved.
//

import UIKit
import UserNotifications

  var odbrojavanje = ""

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    runCountdown()
    updateTime()
    
        
    }
  
    
    @IBOutlet weak var labelaArandjelovdan: UILabel!
    
    @IBAction func belgrade(_ sender: Any) {
    }
    
    var tekstBeograd:String = ""
    var tekstRodjendan:String = ""
    var tekstOdmor:String = ""
    var tekstIzrael:String = ""
    
    let futureDate: Date = {
        var future = DateComponents(
            year: 2019,
            month: 12,
            day: 13,
            hour: 12,
            minute: 0,
            second: 0
        )
        print(future)
        return Calendar.current.date(from: future)!
        
    }()
    
    var countdown: DateComponents {
        return Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(), to: futureDate)
    }
    
    func scheduleLocalPrime() {
        
                  let center = UNUserNotificationCenter.current()
                  center.removeAllPendingNotificationRequests()
        
            let countdown = self.countdown
            let date = countdown.day!
        
                  let content = UNMutableNotificationContent()
                  content.title = "Sofia je u Egiptu"
                  content.body = "Ali dolazi za \(String(format: "%02d dana", date - 1)) :)"
                  content.categoryIdentifier = "alarm"
                  content.userInfo = ["customData": "fizzbuzz"]
                  content.sound = .default
                  
                  var dateComopnets = DateComponents()
                  dateComopnets.hour = 10
                  dateComopnets.minute = 50
                  
                  let trigger = UNCalendarNotificationTrigger(dateMatching: dateComopnets, repeats: true)
                  
                  let requst = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                  center.add(requst)
    }

    
    @objc func updateTime() {
        
        let countdown = self.countdown //only compute once per call
        let days = countdown.day!
        let hours = countdown.hour!
        let minutes = countdown.minute!
        let seconds = countdown.second!

        if days > 0 {
             labelaArandjelovdan.text = String(format: "%02dd %02dh %02dm %02ds", days, hours, minutes, seconds)
        }else{
         labelaArandjelovdan.text = "Dosla je"
        
        }
    }

    func runCountdown() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
        func registerLocal() {
            let center = UNUserNotificationCenter.current()
            
            center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if granted {
                    print("Yay!")
                } else {
                    print("D'oh!")
                }
            }
        }
}
