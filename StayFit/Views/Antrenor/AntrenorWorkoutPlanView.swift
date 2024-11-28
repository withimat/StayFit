//
//  AntrenorWorkoutPlanView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 19.11.2024.
//

import SwiftUI

struct AntrenorWorkoutPlanView: View {
    let student: Student
    @StateObject private var viewModel = WorkoutPlanViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var showAlert = false
    @State private var alertMessage = ""
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Text("Öğrencinize vereceğiniz antrenman planının detaylarını buraya giriniz.")
                    Section {
                        
                        TextField("Başlık", text: $viewModel.title)
                        ZStack {
                            if viewModel.description.isEmpty {
                                Text("Açıklama giriniz...")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 12)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            TextEditor(text: $viewModel.description)
                                .padding(8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                        }
                        .frame(height: 150)
                        DatePicker("Başlangıç Tarihi", selection: $viewModel.startDate, displayedComponents: .date)
                        DatePicker("Bitiş Tarihi", selection: $viewModel.endDate, displayedComponents: .date)
                    }
                    
                    
                    Button(action: {
                        viewModel.subscriptionId = student.id
                        viewModel.memberId = student.memberId
                        viewModel.createWorkoutPlan()
                        
                        // Alert ve temizleme işlemi
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            if viewModel.errorMessage == "Plan başarıyla gönderildi" {
                                alertMessage = viewModel.errorMessage ?? ""
                                showAlert = true
                                viewModel.resetFields() // Alanları temizleme
                            } else {
                                alertMessage = viewModel.errorMessage ?? "Bilinmeyen bir hata oluştu."
                                showAlert = true
                            }
                        }
                    }) {
                        if viewModel.isSubmitting {
                            ProgressView()
                        } else {
                            Text("Planı oluştur")
                        }
                    }
                    .disabled(viewModel.isSubmitting || viewModel.title.isEmpty || viewModel.description.isEmpty)
                }
                .frame(height: 600)
                .cornerRadius(10)
                .padding(.horizontal)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Durum"), message: Text(alertMessage), dismissButton: .default(Text("Tamam")))
            }
            .navigationBarTitle("Antrenman Planı Hazırla")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                        .imageScale(.large)
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
        }
    }
}

#Preview {
    AntrenorWorkoutPlanView(student: Student(id: "12", memberId: "12", endDate: "11/21", amount: 5500, height: 180, weight: 80, firstName: "İmat", lastName: "Gokaslan", gender: 0, birthDate: "15/08", photoPath: "", goal: ""))
}
