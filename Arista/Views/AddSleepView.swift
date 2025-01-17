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
                    .listRowBackground(Color.clear)
                    
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
                    .listRowBackground(Color.clear)
                    
                    VStack {
                        Text("Qualité")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Slider(value: $viewModel.sleepModel.quality, in: 1...100, step: 1)
                                {Text("Qualité")}
                                minimumValueLabel: { Text("1")}
                                maximumValueLabel: {Text("100")}
                        Text(String(format: "%.0f", viewModel.sleepModel.quality))
                    }
                    .listRowBackground(Color.clear)
                    
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
                        .listRowBackground(Color.clear)
                        .transition(.move(edge: .top))
                        .zIndex(1)
                    }
                    
                    
                }
                .formStyle(.grouped)
                .scrollContentBackground(.hidden)
                
                Spacer()
                Button("Ajouter") {
                    if viewModel.addSleep() {
                        presentationMode.wrappedValue.dismiss()
                    }
                }.buttonStyle(.borderedProminent)
                    
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.fondDe.opacity(0.6), Color.fondA.opacity(0.6)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .navigationTitle("Sommeil")
            
            
        }
    }
}

#Preview {
    AddExerciseView(viewModel: AddExerciseViewModel())
}
