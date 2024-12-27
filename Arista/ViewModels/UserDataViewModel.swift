//
//  UserDataViewModel.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import Foundation

class UserDataViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""

    init() {
        fetchUserData()
    }

    private func fetchUserData() {
        do {
            guard let user = try UserRepository().getUser() else {
                fatalError()
            }
            firstName = user.firstName ?? ""
            lastName = user.lastName ?? ""
        } catch {
            
        }
    }
}
