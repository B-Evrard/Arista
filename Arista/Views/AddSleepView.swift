//
//  AddSleepView.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import SwiftUI

struct AddSleepView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: AddSleepViewModel

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    HStack {
                        Text("Début")
                        Spacer()
                        DatePicker("Début",
                                   selection:  $viewModel.sleepModel.startDate,
                                   displayedComponents: [.date, .hourAndMinute]
                        )
                        .datePickerStyle(DefaultDatePickerStyle())
                        .labelsHidden()
                    }
                    
                    HStack {
                        Text("Fin")
                        Spacer()
                        DatePicker("Fin",
                                   selection:  $viewModel.sleepModel.endDate,
                                   displayedComponents: [.date, .hourAndMinute]
                        )
                        .datePickerStyle(DefaultDatePickerStyle())
                        .labelsHidden()
                    }
                    
                    VStack {
                        Text("Qualité")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Slider(value: $viewModel.sleepModel.quality, in: 1...100, step: 1)
                                {Text("Qualité")}
                                minimumValueLabel: { Text("1")}
                                maximumValueLabel: {Text("100")}
                        Text(String(format: "%.0f", viewModel.sleepModel.quality))
                    }
                    
                    if viewModel.showAlert {
                        VStack {
                            Spacer()
                            Text(viewModel.messageAlert)
                                    .foregroundColor(.white)
                                    .bold()
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(8)
                                    .shadow(radius: 10)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Spacer()
                        }
                        .transition(.move(edge: .top))
                        .zIndex(1)
                    }
                    
                    
                }.formStyle(.grouped)
                Spacer()
                Button("Ajouter") {
                    if viewModel.addSleep() {
                        presentationMode.wrappedValue.dismiss()
                    }
                }.buttonStyle(.borderedProminent)
                    
            }
            .navigationTitle("Nouvel Exercice")
            
            
        }
    }
}

#Preview {
    AddExerciseView(viewModel: AddExerciseViewModel())
}
