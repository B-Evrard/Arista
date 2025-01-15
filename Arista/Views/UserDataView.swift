//
//  UserDataView.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import SwiftUI

struct UserDataView: View {
    @ObservedObject var viewModel: UserDataViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("Hello")
                .font(.largeTitle)
            Text(viewModel.fullName)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .padding()
                .scaleEffect(1.2)
                .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: UUID())
            Spacer()
        }
        .alert("Erreur", isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Une erreur est survenue")
        }
        .edgesIgnoringSafeArea(.all)
        .backgroundImage("Fond")
    }
}

#Preview {
    //UserDataView(viewModel: UserDataViewModel())
}
