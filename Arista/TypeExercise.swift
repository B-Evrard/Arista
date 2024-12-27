//
//  TypeExercise.swift
//  Arista
//
//  Created by Bruno Evrard on 26/12/2024.
//

import Foundation

enum TypeExercise: String,CaseIterable {
    case football
    case natation
    case running
    case marche
    case cyclisme
    
    var icon: String {
        switch self {
        case .football:
            return "sportscourt"
        case .natation:
            return "waveform.path.ecg"
        case .running:
            return "figure.run"
        case .marche:
            return "figure.walk"
        default:
            return "questionmark"
        }
    }
    
    func alltype() -> [String] {
        return TypeExercise.allCases.map { String(describing: $0) }
    }
}


extension TypeExercise {
    static func from(rawValue: String) -> TypeExercise? {
        return TypeExercise(rawValue: rawValue)
    }
}
