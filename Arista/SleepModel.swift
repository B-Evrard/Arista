//
//  SleepModel.swift
//  Arista
//
//  Created by Bruno Evrard on 02/01/2025.
//

import Foundation

struct SleepModel: Identifiable {
    
    var id: UUID = UUID()
    
    var quality: Int
    var startDate: Date
    var endDate: Date
    
    var startDateFormatted: String {
        Utils.formattedDate(startDate)
    }
    
    var endDateFormatted: String {
        Utils.formattedDate(endDate)
    }
    
}
