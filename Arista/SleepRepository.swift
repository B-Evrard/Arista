//
//  SleepRepository.swift
//  Arista
//
//  Created by Bruno Evrard on 18/12/2024.
//

import Foundation
import CoreData

struct SleepRepository {
    let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
    }
    
    func getSleepSessions() throws -> [SleepModel] {
        let request = Sleep.fetchRequest()
        request.sortDescriptors =  [NSSortDescriptor(SortDescriptor<Sleep>(\.startDate, order: .reverse) )]
        return try viewContext.fetch (request).map { toModel($0) }
    }
    
    func toModel(_ sleep: Sleep) -> SleepModel {
        return SleepModel(
            quality: Int(sleep.quality),
            startDate: sleep.startDate ?? Date(),
            endDate: sleep.endDate ?? Date()
        )
    }
    
    func toEntity(_ model: SleepModel) -> Sleep {
        let sleep = Sleep(context: viewContext)
        sleep.quality = Int16(model.quality)
        sleep.startDate = model.startDate
        sleep.endDate = model.endDate
        return sleep
    }
    
}
