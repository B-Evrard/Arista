//
//  ExerciseType.swift
//  Arista
//
//  Created by Bruno Evrard on 26/12/2024.
//

import Foundation

enum ExerciseType: String,CaseIterable {
    
    case football
    case natation
    case running
    case marche
    case cyclisme
    case unknown
    
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
        case .cyclisme:
            return "bicycle"
        case .unknown:
            return "questionmark"
        }
    }
    
    init (rawValue: String) {
        switch rawValue {
        case "footbal":
            self = .football
        case "natation":
            self = .natation
        case "running":
            self = .running
        case "marche":
            self = .marche
        case "cyclisme":
            self = .cyclisme
        default :
            self = .unknown
            
        }
    }
    
    func alltype() -> [String] {
        return ExerciseType.allCases.filter({ $0 != .unknown}).map { String(describing: $0) }
    }
}



