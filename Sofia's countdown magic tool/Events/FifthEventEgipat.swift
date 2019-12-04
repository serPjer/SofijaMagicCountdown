//
//  FifthEvent.swift
//  Sofia's countdown magic tool
//
//  Created by Petar Stijepcic on 9/4/19.
//  Copyright © 2019 Pi Solution. All rights reserved.
//

import UIKit
import UserNotifications

class FifthEventEgipat: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTime()
        runCountdown()
        registerLocal()
        scheduleLocal51()
    }
    
    @IBOutlet weak var labelaArandjelovdan: UILabel!
    @IBOutlet weak var labelaEgipat: UILabel!
    
    let futureDate: Date = {
        var future = DateComponents(
            year: 2019,
            month: 12,
            day: 13,
            hour: 12,
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
        labelaEgipat.text = "A to ce biti za \(String(format: "%02dd %02dh %02dm %02ds", days, hours, minutes, seconds))"
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
    
    func scheduleLocal51() {
                  let center = UNUserNotificationCenter.current()
                  center.removeAllPendingNotificationRequests()
        
            let countdown = self.countdown
                       let date = countdown.day!

                  let content = UNMutableNotificationContent()
                  content.title = "Sofija me ceka u Istanbulu \(String(format: "%02d dana", date - 1))"
                  content.body = "Kako cemo lepo da se provedemo"
                  content.categoryIdentifier = "alarm"
                  content.userInfo = ["customData": "fizzbuzz"]
                  content.sound = .default
        
        if date <= 0 {
                   content.title = "Ustaj, Sofija te ceka naga"
                   content.body = "Ima sve da puca"
            
//                    var dateComponents = DateComponents()
//                        dateComponents.hour = 19
//                        dateComponents.minute = 38
            
               } else {
                   content.title = "Sofija me ceka u Istanbulu \(String(format: "%02d dana", date - 1))"
                   content.body = "Kako cemo lepo da se provedemo :)"
               }

        if date <= 0 {
            var dateComopnets = DateComponents()
            dateComopnets.hour = 08
            dateComopnets.minute = 30

            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComopnets, repeats: true)

            let requst = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(requst)
            
        } else {
                  var dateComopnets = DateComponents()
                  dateComopnets.hour = 12
                  dateComopnets.minute = 20
                  let trigger = UNCalendarNotificationTrigger(dateMatching: dateComopnets, repeats: true)

                  let requst = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                  center.add(requst)
            
            UIApplication.shared.applicationIconBadgeNumber = 0
       
        }
    }
    
    

}
