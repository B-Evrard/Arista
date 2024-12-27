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
        
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        var batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try? viewContext.execute(batchDeleteRequest)
        
        fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Sleep")
        batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try? viewContext.execute(batchDeleteRequest)
        
        let userRepository = UserRepository(viewContext: viewContext)
        let sleepRepository = SleepRepository(viewContext: viewContext)
        if (try? userRepository.getUser()) == nil {
            let initialUser = User(context: viewContext)
            initialUser.firstName = "Charlotte"
            initialUser.lastName = "Razoul"
            initialUser.password = "motdepasseLong"
            
            if try sleepRepository.getSleepSessions().isEmpty {
                let sleep1 = Sleep(context: viewContext)
                let sleep2 = Sleep(context: viewContext)
                let sleep3 = Sleep(context: viewContext)
                let sleep4 = Sleep(context: viewContext)
                let sleep5 = Sleep(context: viewContext)
                
                var sleepSessions: [(start: Date, end: Date, quality: Int16)] = []
                
                let startHourRange: TimeInterval = 22 * 60 * 60 // 22:00
                let endHourRange: TimeInterval = 23.5 * 60 * 60 // 23:30

                
                let minSleepDuration: TimeInterval = 7 * 60 * 60 // 7 heures
                let maxSleepDuration: TimeInterval = 8 * 60 * 60 // 8 heures

                for i in 1...5 {
                    
                    let dayOffset = TimeInterval(-i * 24 * 60 * 60) // i jours dans le passé
                    let baseDate = Calendar.current.startOfDay(for: Date()).addingTimeInterval(dayOffset)

                    let randomStartTime = TimeInterval.random(in: startHourRange...endHourRange)
                    let sleepStart = baseDate.addingTimeInterval(randomStartTime)

                    let randomSleepDuration = TimeInterval.random(in: minSleepDuration...maxSleepDuration)
                    let sleepEnd = sleepStart.addingTimeInterval(randomSleepDuration)
                    
                    let qualityOfSleep = Int16.random(in: 60...100)
                    sleepSessions.append((start: sleepStart, end: sleepEnd, quality: qualityOfSleep))
                }

                sleep1.startDate = sleepSessions[0].start
                sleep1.endDate = sleepSessions[0].end
                sleep1.quality = sleepSessions[0].quality
                sleep1.user = initialUser
                
                sleep2.startDate = sleepSessions[1].start
                sleep2.endDate = sleepSessions[1].end
                sleep2.quality = sleepSessions[1].quality
                sleep2.user = initialUser
                
                sleep3.startDate = sleepSessions[2].start
                sleep3.endDate = sleepSessions[2].end
                sleep3.quality = sleepSessions[2].quality
                sleep3.user = initialUser
                
                sleep4.startDate = sleepSessions[3].start
                sleep4.endDate = sleepSessions[3].end
                sleep4.quality = sleepSessions[3].quality
                sleep4.user = initialUser
                
                sleep5.startDate = sleepSessions[4].start
                sleep5.endDate = sleepSessions[4].end
                sleep5.quality = sleepSessions[4].quality
                sleep5.user = initialUser
            }
            
            try? viewContext.save()
        }
        
    }
}
