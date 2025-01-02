//
//  Utils.swift
//  Arista
//
//  Created by Bruno Evrard on 02/01/2025.
//

import Foundation

class Utils  {
    
    static func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy 'à' HH:mm"
        return "Le \(dateFormatter.string(from: date))"
    }
    
    
}
