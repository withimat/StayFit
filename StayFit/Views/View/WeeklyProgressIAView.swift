//
//  WeeklyProgressIAView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 25.11.2024.
//

import SwiftUI

struct WeeklyProgressIAView: View {
    @StateObject private var viewModel = WeeklyProgressIAModelView()
    @State private var isImagePickerPresented: Bool = false
    @State private var showAlert = false
    @Environment(\.dismiss) var dismiss
    let antrenor : GelenAntrenor
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Kişisel Bilgiler")) {
                    TextField("Boy", text: $viewModel.height)
                        .keyboardType(.numberPad)
                    TextField("Kilo", text: $viewModel.weight)
                        .keyboardType(.decimalPad)
                   
                }
                
                Section(header: Text("Fotoğraflar")) {
                    Button("Fotoğraf Ekle") {
                        isImagePickerPresented = true
                    }
                    
                    if !viewModel.selectedImages.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.selectedImages.indices, id: \.self) { index in
                                    Image(uiImage: viewModel.selectedImages[index])
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .overlay(
                                            Button(action: {
                                                viewModel.removeImage(at: index)
                                            }) {
                                                Image(systemName: "xmark.circle.fill")
                                                    .foregroundColor(.red)
                                                    .padding(4)
                                            }
                                            .offset(x: 40, y: -40),
                                            alignment: .topTrailing
                                        )
                                }
                            }
                        }
                        .frame(height: 120)
                    }
                }
                
                Button(action: {
                    viewModel.submitForm()
                    viewModel.resetField()
                }) {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text("Kaydet")
                    }
                }
                .disabled(viewModel.isLoading)
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        WeeklyProgressResultView(subscriptionId: viewModel.subscriptionId)
                    } label: {
                        Text("sonucları gör")
                    }

                }
            }
            .navigationTitle("Yapay Zeka İle Ölç")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: Binding(
                    get: { UIImage() },
                    set: { newImage in
                        if let image = newImage {
                            viewModel.addImage(image)
                        }
                    }
                ))
            }
            .alert(isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { _ in viewModel.errorMessage = nil }
            )) {
                Alert(
                    title: Text("Bilgi"),
                    message: Text(viewModel.errorMessage ?? "Bilinmeyen bir hata oluştu"),
                    dismissButton: .default(Text("Tamam"))
                )
            }
        }
        .onAppear(){
            viewModel.subscriptionId = antrenor.subscriptionId
            print(viewModel.subscriptionId)
        }
    }
}

#Preview {
    WeeklyProgressIAView(antrenor: GelenAntrenor(subscriptionId: "", trainerId: "", firstName: "", lastName: "", amount: 0, endDate: ""))
}
