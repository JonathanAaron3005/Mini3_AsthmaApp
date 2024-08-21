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
    @State private var timeFormatter = ElapsedTimeFormatter()

    var body: some View {
        VStack {

            ProgressView(value: elapsedTime, total: workoutDuration)
                .progressViewStyle(LinearProgressViewStyle(tint: progressBarColor))
                .padding()
            
            Text(NSNumber(value: elapsedTime), formatter: timeFormatter)
                .fontWeight(.semibold)
                .onChange(of: showSubseconds) { (oldValue, newValue) in
                    timeFormatter.showSubseconds = newValue
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

class ElapsedTimeFormatter: Formatter {
    let componentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    var showSubseconds = true

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
