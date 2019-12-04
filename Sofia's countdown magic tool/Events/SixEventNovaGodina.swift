//
//  SixEventNovaGodina.swift
//  Sofia's countdown magic tool
//
//  Created by Petar Stijepcic on 10/31/19.
//  Copyright © 2019 Pi Solution. All rights reserved.
//

import UIKit
import UserNotifications


//func scheduleLocal6() {
//
//
//
//              let center = UNUserNotificationCenter.current()
//              center.removeAllPendingNotificationRequests()
//
//              let content = UNMutableNotificationContent()
//              content.title = "Sofia ceka mene da dodjem"
//              content.body = "Krtola ce da gori u 2020-toj godini"
//              content.categoryIdentifier = "alarm"
//              content.userInfo = ["customData": "fizzbuzz"]
//              content.sound = .default
//
//              var dateComopnets = DateComponents()
//              dateComopnets.hour = 04
//              dateComopnets.minute = 00
//
//              let trigger = UNCalendarNotificationTrigger(dateMatching: dateComopnets, repeats: true)
//
//              let requst = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//              center.add(requst)
//}

class SixEventNovaGodina: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTime()
        runCountdown()
        registerLocal()
        scheduleLocal61()
        
    }
    
    @IBOutlet weak var labelaNovaGodina: UILabel!
    
    
    
    let futureDate: Date = {
        var future = DateComponents(
            year: 2019,
            month: 12,
            day: 31,
            hour: 00,
            minute: 00,
            second: 0
        )
        return Calendar.current.date(from: future)!
    }()
    
    var countdown: DateComponents {
        return Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(), to: futureDate)
    }
    
    @objc func updateTime() {
        let countdown = self.countdown //only compute once per call
        let days = countdown.day!
        let hours = countdown.hour!
        let minutes = countdown.minute!
        let seconds = countdown.second!
        
        if days >= 0 {

       labelaNovaGodina.text = "Cekamo za \(String(format: "%02dd %02dh %02dm %02ds", days, hours, minutes, seconds))"
        }else{
            labelaNovaGodina.text = "Usli smo u novu godinu"
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
    
    func scheduleLocal61() {
                  let center = UNUserNotificationCenter.current()
                  center.removeAllPendingNotificationRequests()
        
            let countdown = self.countdown
                       let date = countdown.day!

                  let content = UNMutableNotificationContent()
                  content.title = "Sofia ceka mene da dodjem za \(String(format: "%02d dana", date - 1))"
                  content.body = "Krtola ce da gori u 2020-toj godini"
                  content.categoryIdentifier = "alarm"
                  content.userInfo = ["customData": "fizzbuzz"]
                  content.sound = .default
        
        if date <= 0 {
                   content.title = "Sofia ceka mene da dodjem"
                   content.body = "Krtola Gori"
               } else {
                   content.body = "Krtola ce da gori u 2020-toj godini"
               }

                  var dateComopnets = DateComponents()
                  dateComopnets.hour = 00
                  dateComopnets.minute = 45

                  let trigger = UNCalendarNotificationTrigger(dateMatching: dateComopnets, repeats: true)

                  let requst = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                  center.add(requst)
    
       
    }
    
   
}
