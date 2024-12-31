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
                    Picker("Catégorie", selection: Binding(
                        get: { viewModel.type },
                        set: { newValue in viewModel.type = newValue }
                    )) {
                        ForEach(ExerciseType.allCases, id: \.self) { type in
                            Text(type.rawValue.capitalized).tag(type)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    
                    HStack {
                        Text("Début")
                        Spacer()
                        DatePicker("Début",
                                   selection:  $viewModel.startTime,
                                   displayedComponents: [.date, .hourAndMinute]
                        )
                        .datePickerStyle(DefaultDatePickerStyle())
                        .labelsHidden()
                    }
                    
                    HStack {
                        Text("Fin")
                        Spacer()
                        DatePicker("Fin",
                                   selection:  $viewModel.endTime,
                                   displayedComponents: [.date, .hourAndMinute]
                        )
                        .datePickerStyle(DefaultDatePickerStyle())
                        .labelsHidden()
                    }
                    
                    VStack {
                        Text("Intensité")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Slider(value: $viewModel.intensity, in: 1...20, step: 1)
                                {Text("Intensité")}
                                minimumValueLabel: { Text("1")}
                                maximumValueLabel: {Text("20")}
                        Text(String(format: "%.0f", viewModel.intensity))
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
