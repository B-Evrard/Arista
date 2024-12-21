//
//  DefaultData.swift
//  Arista
//
//  Created by Bruno Evrard on 20/12/2024.
//

import Foundation
import CoreData
struct DefaultData {
    let viewContext: NSManagedObjectContext
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
    }
    
    func apply() throws {
        let userRepository = UserRepository(viewContext: viewContext)
        let sleepRepository = SleepRepository(viewContext: viewContext)
        if (try? userRepository.getUser()) == nil {
            let initialUser = User(context: viewContext)
            initialUser.firstName = "Charlotte"
            initialUser.lastName = "Razoul"
            
            if try sleepRepository.getSleepSessions().isEmpty {
                let sleep1 = Sleep(context: viewContext)
                let sleep2 = Sleep(context: viewContext)
                let sleep3 = Sleep(context: viewContext)
                let sleep4 = Sleep(context: viewContext)
                let sleep5 = Sleep(context: viewContext)
                
                var sleepSessions: [(start: Date, end: Date)] = []
                
                let startHourRange: TimeInterval = 20 * 60 * 60 // 20:00
                let endHourRange: TimeInterval = 22.5 * 60 * 60 // 22:30

                
                let minSleepDuration: TimeInterval = 5 * 60 * 60 // 5 heures
                let maxSleepDuration: TimeInterval = 8 * 60 * 60 // 8 heures

                for i in 1...5 {
                    
                    let dayOffset = TimeInterval(-i * 24 * 60 * 60) // i jours dans le passé
                    let baseDate = Calendar.current.startOfDay(for: Date()).addingTimeInterval(dayOffset)

                    let randomStartTime = TimeInterval.random(in: startHourRange...endHourRange)
                    let sleepStart = baseDate.addingTimeInterval(randomStartTime)

                    let randomSleepDuration = TimeInterval.random(in: minSleepDuration...maxSleepDuration)
                    let sleepEnd = sleepStart.addingTimeInterval(randomSleepDuration)

                    sleepSessions.append((start: sleepStart, end: sleepEnd))
                }

                sleep1.startDate = sleepSessions[0].start
                sleep1.endDate = sleepSessions[0].end
                sleep1.user = initialUser
                
                sleep1.startDate = sleepSessions[1].start
                sleep1.endDate = sleepSessions[1].end
                sleep1.user = initialUser
                
                sleep1.startDate = sleepSessions[2].start
                sleep1.endDate = sleepSessions[2].end
                sleep1.user = initialUser
                
                sleep1.startDate = sleepSessions[3].start
                sleep1.endDate = sleepSessions[3].end
                sleep1.user = initialUser
                
                sleep1.startDate = sleepSessions[4].start
                sleep1.endDate = sleepSessions[4].end
                sleep1.user = initialUser
            }
            
            try? viewContext.save()
        }
        
    }
}
