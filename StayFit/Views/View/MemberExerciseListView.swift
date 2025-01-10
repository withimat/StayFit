//
//  MemberExerciseListView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 24.11.2024.
//

import SwiftUI

struct MemberExerciseListView: View {
    @StateObject private var viewModel = ExerciseViewModel()
    var workoutdays: WorkoutDays
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if viewModel.exercises.isEmpty {
                        Text("Henüz eklenmiş bir egzersiz yok.")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ForEach(viewModel.exercises.sorted(by: { $0.priority < $1.priority }), id: \.name) { exercise in
                            NavigationLink {
                                ExerciseDetailView(exercise: exercise)
                            } label: {
                                MemberExerciseRowView(exercise: exercise)
                                    .padding(.horizontal)
                                    .padding(.bottom)
                            }
                        }
                    }
                    Spacer()
                }
                .navigationTitle("Egzersiz Listesi")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Image(systemName: "chevron.left")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                            .onTapGesture {
                                dismiss()
                            }
                    }
                }
                .onAppear {
                    viewModel.WorkoutId = workoutdays.id
                    viewModel.fetchExercises(for: workoutdays.id)
                }
            }
        }
    }

    private func deleteWorkout(at offsets: IndexSet) {
        viewModel.exercises.remove(atOffsets: offsets)
    }
}

#Preview {
    MemberExerciseListView(workoutdays: WorkoutDays(id: 2, title: "", dayOfWeek: 1, isCompleted: false))
}
