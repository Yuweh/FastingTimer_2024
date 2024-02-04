//
//  FastingManager.swift
//  FastingTimer
//
//  Created by yuweh on 04/02/2024.
//

import Foundation
import SwiftUI

enum FastingState {
    case notStarted
    case fasting
    case feeding
}


enum FastingPlan: String {
    case beginner = "12:12"
    case intermediate = "16:8"
    case advanced = "20:4"
    
    var fastingPeriod: Double {
        switch self {
        case .beginner:
            return 12
        case .intermediate:
            return 16
        case .advanced:
            return 20
        }
    }
}

class FastingManager: ObservableObject {
    @Published private(set) var fastingState: FastingState = .notStarted
    @Published private(set) var fastingPlan: FastingPlan = .beginner
    @Published private(set) var startTime: Date {
        didSet {
            print("startTime:", startTime.formatted(.dateTime.month().hour().minute().second()))
            
            if fastingState == .fasting {
                endTime = startTime.addingTimeInterval(fastingTime)
            } else {
                endTime = startTime.addingTimeInterval(feedingTime)
            }
        }
    }
    @Published private(set) var endTime: Date {
        didSet {
            print("endTime:", endTime.formatted(.dateTime.month().hour().minute().second()))
        }
    }
    @Published private(set) var elapsed: Bool = false
    
    var fastingTime: Double {
        return fastingPlan.fastingPeriod
    }
    
    var feedingTime: Double {
        return 24 - fastingPlan.fastingPeriod
    }
    
    init() {
        let calendar = Calendar.current
        
//        var components = calendar.dateComponents([.year, .month, .day, .hour], from: Date())
//        components.hour = 20
//        print("components: \(components)")
//        
//        let scheduledTime = calendar.date(from: components) ?? Date.now
//        print("schedultedTime:", schedultedTime.formatted(.dateTime.month().hour().minute().second()))
        
        let components = DateComponents(hour: 20)
        let scheduledTime = calendar.nextDate(after: .now, matching: components, matchingPolicy: .nextTime)!
        print("schedultedTime:", scheduledTime.formatted(.dateTime.month().hour().minute().second()))
        
        startTime = scheduledTime
        endTime = scheduledTime.addingTimeInterval(FastingPlan.beginner.fastingPeriod)
    }
    
    
    func toggleFastingState() {
        fastingState = fastingState == .fasting ? .feeding : .fasting
        startTime = Date()
    }
    
    func track() {
        guard fastingState != .notStarted else { return }
        print("trackTime Now:", Date().formatted(.dateTime.month().hour().minute().second()))
        
        if endTime >= Date() {
            print("Not elapsed")
            elapsed = false
        } else {
            print("elapsed")
            elapsed = true
        }
    }
    
}
