//
//  FirstEvent.swift
//  Sofia's countdown magic tool
//
//  Created by Petar Stijepcic on 9/3/19.
//  Copyright © 2019 Pi Solution. All rights reserved.
//

import UIKit

class FirstEvent: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        updateTime()
        runCountdown()
    
    }
    
    @IBOutlet weak var komentarBeograd: UILabel!
    
    let futureDate: Date = {
        var future = DateComponents(
            year: 2019,
            month: 09,
            day: 26,
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
        
        if days > 0 {
        komentarBeograd.text = "I can't wait to see her, wake me up when she comes in \(String(format: "%02dd %02dh %02dm %02ds", days, hours, minutes, seconds))"
        } else{
            komentarBeograd.text = "Dosla je i sad uzivamo zajedno"
        }
    
    }
    
    func runCountdown() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
}
