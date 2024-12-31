//
//  ExerciseModel.swift
//  Arista
//
//  Created by Bruno Evrard on 30/12/2024.
//

import Foundation

struct ExerciseModel: Identifiable {
    var id: UUID = UUID()
    
    var type: ExerciseType
    var intensity: Int
    var startDate: Date
    var endDate: Date

    var duration: String {
         "\(Int(round(endDate.timeIntervalSince(startDate)/60))) minutes"
    }
    
}
