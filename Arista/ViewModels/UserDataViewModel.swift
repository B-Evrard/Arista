//
//  UserDataViewModel.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import Foundation

class UserDataViewModel: ObservableObject {
    @Published var userModel: UserModel?
    @Published var showError = false
    
    var fullName: String {
       return "\(userModel?.firstName ?? "") \(userModel?.lastName ?? "")"
    }

    init(){
        fetchUserData()
    }

    private func fetchUserData() {
        do {
            self.showError = false
            let user = try UserRepository().getUser()
            userModel = toModel(user)
        } catch {
            self.showError = true
        }
    }
    
    func toModel(_ user: User) -> UserModel {
        return UserModel(
            firstName: user.firstName ?? "",
            lastName: user.lastName ?? "",
            password: user.password ?? ""
        )
    }
    
    
}
