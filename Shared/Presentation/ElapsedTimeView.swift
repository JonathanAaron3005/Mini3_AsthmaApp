//
//  ElapsedTimeView.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 20/08/24.
//

import SwiftUI

struct ElapsedTimeView: View {
    var elapsedTime: TimeInterval = 0
    var workoutDuration: TimeInterval
    var showSubseconds = true
    var showWorkoutDuration: Bool = false // New flag to control visibility of workout duration
    
    @State private var timeFormatter = ElapsedTimeFormatter()
    
    var body: some View {
        VStack {
            if showWorkoutDuration {
                ProgressView(value: elapsedTime, total: workoutDuration)
                    .progressViewStyle(LinearProgressViewStyle(tint: progressBarColor))
                    .padding()
            }
            
            Text(NSNumber(value: elapsedTime), formatter: timeFormatter)
                .fontWeight(.semibold)
                .onAppear {
                    timeFormatter.showSubseconds = showSubseconds // This should be false for watch
                }
        }
    }
    
    private var progressBarColor: Color {
        switch elapsedTime / workoutDuration {
        case 1...:
            return .yellow
        default:
            return .green
        }
    }
}

// Function to determine if the app is running on iPhone
private func isRunningOniPhone() -> Bool {
#if os(iOS)
    return true
#else
    return false
#endif
}


class ElapsedTimeFormatter: Formatter {
    let componentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        formatter.unitsStyle = .positional
        return formatter
    }()
    
    var showSubseconds = false
    
    override func string(for value: Any?) -> String? {
        guard let time = value as? TimeInterval else {
            return nil
        }
        
        guard let formattedString = componentsFormatter.string(from: time) else {
            return nil
        }
        
        if showSubseconds {
            let hundredths = Int((time.truncatingRemainder(dividingBy: 1)) * 100)
            let decimalSeparator = Locale.current.decimalSeparator ?? "."
            return String(format: "%@%@%0.2d", formattedString, decimalSeparator, hundredths)
        }
        
        return formattedString
    }
}
