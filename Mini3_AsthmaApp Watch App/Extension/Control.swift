//
//  Control.swift
//  Mini3_AsthmaApp Watch App
//
//  Created by Kevin Fairuz on 20/08/24.
//

import Foundation
import HealthKit

extension HKWorkoutSession {
    func toggle () {
        if ( self.state == .running ) {
            self.pause()
        } else {
            self.resume()
        }
    }
    
    
}
