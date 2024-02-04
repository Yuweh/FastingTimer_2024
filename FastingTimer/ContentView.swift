//
//  ContentView.swift
//  FastingTimer
//
//  Created by yuweh on 04/02/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var fastingManager = FastingManager()
    
    var title: String {
        switch fastingManager.fastingState {
        case .notStarted:
            return "Let's get started!"
        case .fasting:
            return "You are now fasting"
        case .feeding:
            return "You should now eat"
        }
    }
    
    var body: some View {
        ZStack {
            //MARK: Background
            Color(#colorLiteral(red: 0.659072908, green: 0.9188345683, blue: 0.8654745702, alpha: 1))
                .ignoresSafeArea()
            content
        }
    }
    
    var content: some View {
        ZStack {
            VStack(spacing: 40) {
                //MARK: Head Title
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color(#colorLiteral(red: 0.1250494802, green: 0.4375847624, blue: 0.9188345683, alpha: 1)))
                
                //MARK: Fasting Plan
                Text(fastingManager.fastingPlan.rawValue)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                
                Spacer()
            }
            .padding()
            
            VStack(spacing: 40) {
                //MARK: Progress Ring
                ProgressRing()
                    .environmentObject(fastingManager)
                
                //MARK: Start/End Time Area
                HStack(spacing: 60) {
                    
                    //MARK: Start Time Label
                    VStack(spacing: 5) {
                        Text(fastingManager.fastingState == .notStarted ? "Start" : "Started")
                            .fontWeight(.bold)
                            .opacity(0.7)
                        
                        Text(fastingManager.startTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.light)
                    }
                    
                    //MARK: End Time Label
                    VStack(spacing: 5) {
                        Text(fastingManager.fastingState == .notStarted ? "End" : "Ends")
                            .fontWeight(.bold)
                            .opacity(0.7)
                        
                        Text(fastingManager.endTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.light)
                    }
                }
                .foregroundColor(.black)
                .padding()
                
                
                //MARK: Action Button
                Button(action: {
                    fastingManager.toggleFastingState()
                }, label: {
                    Text(fastingManager.fastingState == .fasting ? "End fasting" : "Start fasting")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                })
            }
        }
    }
}

#Preview {
    ContentView()
}
