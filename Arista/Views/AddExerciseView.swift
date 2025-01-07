//
//  AddExerciseView.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import SwiftUI

struct AddExerciseView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: AddExerciseViewModel

    var body: some View {
        NavigationView {
            VStack {
                Form {

                    Menu {
                        ForEach(ExerciseType.allCasesExcludingUnknown, id: \.self) { type in
                            Button(action: {
                                viewModel.exercise.type = type
                            }) {
                                HStack {
                                    if viewModel.exercise.type == type {
                                        Image(systemName: "checkmark")
                                    }
                                    Text(type.rawValue.capitalized)
                                }
                            }
                        }

                        
                    } label: {
                        Text(viewModel.exercise.type == .unknown ? "Sélectionner une catégorie" : viewModel.exercise.type.rawValue.capitalized)
                            .foregroundColor(viewModel.exercise.type == .unknown ? Color.gray : Color.blue)
                    }
                    
                    HStack {
                        Text("Début")
                        Spacer()
                        DatePicker("Début",
                                   selection:  $viewModel.exercise.startDate,
                                   displayedComponents: [.date, .hourAndMinute]
                        )
                        .datePickerStyle(DefaultDatePickerStyle())
                        .labelsHidden()
                    }
                    
                    HStack {
                        Text("Fin")
                        Spacer()
                        DatePicker("Fin",
                                   selection:  $viewModel.exercise.endDate,
                                   displayedComponents: [.date, .hourAndMinute]
                        )
                        .datePickerStyle(DefaultDatePickerStyle())
                        .labelsHidden()
                    }
                    
                    VStack {
                        Text("Intensité")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Slider(value: $viewModel.exercise.intensity, in: 1...20, step: 1)
                                {Text("Intensité")}
                                minimumValueLabel: { Text("1")}
                                maximumValueLabel: {Text("20")}
                        Text(String(format: "%.0f", viewModel.exercise.intensity))
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
                Button("Ajouter l'exercice") {
                    if viewModel.addExercise() {
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
