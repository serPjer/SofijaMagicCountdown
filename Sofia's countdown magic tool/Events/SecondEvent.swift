//
//  SecondEvent.swift
//  Sofia's countdown magic tool
//
//  Created by Petar Stijepcic on 9/4/19.
//  Copyright © 2019 Pi Solution. All rights reserved.
//

import UIKit
import UserNotifications


//func scheduleLocal1() {
//              let center = UNUserNotificationCenter.current()
//              center.removeAllPendingNotificationRequests()
//
//              let content = UNMutableNotificationContent()
//              content.title = "Sofia je proslavila rodjendan"
//              content.body = "Ona nije znala durove i molove ali Ika je svirao iz G17+"
//              content.categoryIdentifier = "alarm"
//              content.userInfo = ["customData": "fizzbuzz"]
//              content.sound = .default
//
//              var dateComopnets = DateComponents()
//              dateComopnets.hour = 12
//              dateComopnets.minute = 01
//
//              let trigger = UNCalendarNotificationTrigger(dateMatching: dateComopnets, repeats: true)
//
//              let requst = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//              center.add(requst)
//}

class SecondEvent: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTime()
        runCountdown()
        scheduleLocal1()
        
    }
    
    @IBOutlet weak var labelaRodjendan: UILabel!
    
    
    
    let futureDate: Date = {
        var future = DateComponents(
            year: 2019,
            month: 10,
            day: 19,
            hour: 0,
            minute: 0,
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
        
        if days > 0 {
            
       labelaRodjendan.text = "We will find out in \(String(format: "%02dd %02dh %02dm %02ds", days, hours, minutes, seconds))"
        }else{
            labelaRodjendan.text = "Slavili smo i bilo je sjano"
        }
    }
    func runCountdown() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func scheduleLocal1() {
        
                  let center = UNUserNotificationCenter.current()
                  center.removeAllPendingNotificationRequests()

                  let content = UNMutableNotificationContent()
                  content.title = "Sofia je proslavila rodjendan"
                  content.body = "Ona nije znala durove i molove ali Ika je svirao iz G17+"
                  content.categoryIdentifier = "alarm"
                  content.userInfo = ["customData": "fizzbuzz"]
                  content.sound = .default

                  var dateComopnets = DateComponents()
                  dateComopnets.hour = 00
                  dateComopnets.minute = 25

                  let trigger = UNCalendarNotificationTrigger(dateMatching: dateComopnets, repeats: true)

                  let requst = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                  center.add(requst)
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
