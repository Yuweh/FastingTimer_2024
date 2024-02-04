//
//  ProgressRing.swift
//  FastingTimer
//
//  Created by yuweh on 04/02/2024.
//

import SwiftUI
import Combine

struct ProgressRing: View {
    @EnvironmentObject var fastingManager: FastingManager
    @State var progress = 0.0
    
    let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack {
            //MARK: Placeholder Ring
            Circle()
                .stroke(lineWidth: 20)
                .foregroundColor(.gray)
                .opacity(0.1)
            
            //MARK: Colored Ring
            Circle()
                .trim(from: 0.0, to: min(progress, 1.0))
                .stroke(AngularGradient(
                    gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),Color(#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)), Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)),Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)),]), center: .center),
                    style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                .rotationEffect((Angle(degrees: 270)))
                .animation(.easeInOut(duration: 1.0), value: progress)
            
            //MARK: Center Text Labels
            VStack(spacing: 30) {
                
                //MARK: Elapsed Text Labels
                VStack(spacing: 5) {
                    if !fastingManager.elapsed {
                        Text("Elapsed time")
                            .opacity(0.7)
                    } else {
                        Text("Extra time")
                            .opacity(0.7)
                    }
                    
                    Text(fastingManager.startTime, style: .timer)
                        .font(.title)
                        .fontWeight(.bold)
                }
                .padding(.top)
                
                //MARK: Remaining Text Labels
                VStack(spacing: 5) {
                    Text("Remaining time")
                        .opacity(0.7)
                    
                    Text(fastingManager.endTime, style: .timer)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
            }
        }
        .frame(width: 250, height: 250)
        .padding()
        .onAppear {
            progress = 1
        }
        .onReceive(timer) { _ in
            fastingManager.track() 
        }
    }
}

#Preview {
    ProgressRing().environmentObject(FastingManager())
}
