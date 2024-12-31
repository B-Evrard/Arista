//
//  ExerciseListView.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import SwiftUI

struct ExerciseListView: View {
    @ObservedObject var viewModel: ExerciseListViewModel
    @State private var showingAddExerciseView = false
    
    var body: some View {
        NavigationView {
            List(viewModel.exercises) { exercise  in
                HStack {
                    Image(systemName: exercise.type.icon)
                    VStack(alignment: .leading) {
                        Text(exercise.type.rawValue)
                            .font(.headline)
                        Text("Durée: \(exercise.duration)")
                        .font(.subheadline)
                        Text(exercise.startDate.formatted())
                        .font(.subheadline)
                        
                    }
                    Spacer()
                    //IntensityIndicator(intensity: exercise.intensity)
                }
            }
            .navigationTitle("Exercices")
            .navigationBarItems(trailing: Button(action: {
                showingAddExerciseView = true
            }) {
                Image(systemName: "plus")
            })
            .navigationBarItems(trailing: Button(action: {
                viewModel.deleteExercise()
            }) {
                Image(systemName: "delete.left")
                    .foregroundColor(.red)
            })
        }
        .sheet(isPresented: $showingAddExerciseView, onDismiss: {
            viewModel.refreshExercises()})
        {
            AddExerciseView(viewModel: AddExerciseViewModel())
        }

        
        
        
    }
    
    
}

struct IntensityIndicator: View {
    var intensity: Int
    
    var body: some View {
        Circle()
            .fill(colorForIntensity(intensity))
            .frame(width: 10, height: 10)
    }
    
    func colorForIntensity(_ intensity: Int) -> Color {
        switch intensity {
        case 0...3:
            return .green
        case 4...6:
            return .yellow
        case 7...10:
            return .red
        default:
            return .gray
        }
    }
}

#Preview {
    ExerciseListView(viewModel: ExerciseListViewModel())
}
