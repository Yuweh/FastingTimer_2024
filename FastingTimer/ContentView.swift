//
//  ContentView.swift
//  FastingTimer
//
//  Created by yuweh on 04/02/2024.
//

import SwiftUI

struct ContentView: View {
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
                Text("Let's get started!")
                    .font(.headline)
                    .foregroundColor(Color(#colorLiteral(red: 0.1250494802, green: 0.4375847624, blue: 0.9188345683, alpha: 1)))
                
                //MARK: Fasting Plan
                Text("16:8")
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
                
                //MARK: Start/End Time Area
                HStack(spacing: 60) {
                    
                    //MARK: Start Time Label
                    VStack(spacing: 5) {
                        Text("Start")
                            .fontWeight(.bold)
                            .opacity(0.7)
                        
                        Text(Date(), format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.light)
                    }
                    
                    //MARK: End Time Label
                    VStack(spacing: 5) {
                        Text("End")
                            .fontWeight(.bold)
                            .opacity(0.7)
                        
                        Text(Date().addingTimeInterval(16), format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.light)
                    }
                }
                .foregroundColor(.black)
                .padding()
                
                
                //MARK: Action Button
                Button(action: {
                    
                }, label: {
                    Text("Start fasting")
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
