//
//  StudentDetailView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 1.11.2024.
//

import SwiftUI

struct StudentDetailView: View {
    let student: Student
    @StateObject private var viewModel = StudentDetailViewModel()
    func formatDate(isoDate: String) -> String {
            let dateFormatter = ISO8601DateFormatter()
            dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

            // ISO 8601 tarihini Date formatına dönüştür
            if let date = dateFormatter.date(from: isoDate) {
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "dd/MM/yyyy"
                return outputFormatter.string(from: date)
            }

        return isoDate
        }
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Öğrenci Bilgileri Başlığı ve Fotoğraf
                    HStack(alignment: .center, spacing: 30) {
                        if let photoPath = student.photoPath, let url = URL(string: photoPath) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    
                            } placeholder: {
                                ProgressView()
                            }
                        } else {
                            Image("hoca")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .foregroundColor(.gray)
                        }
                        
                        
                        Text("\(student.firstName) \(student.lastName)")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal)
                    
                    let screenWidth = UIScreen.main.bounds.width
                    
                    // Öğrenci Bilgileri
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Öğrenci Bilgileri")
                            .fontWeight(.semibold)
                            .font(.headline)
                        
                        Group {
                            Text("Abonelik Bitiş Tarihi : \t \(formatDate(isoDate: student.endDate))")
                            Divider()
                            Text("Abonelik Ücreti        : \t \(student.amount) TL")
                            Divider()
                            Text("Boy                            : \t \(student.height) cm")
                            Divider()
                            Text("Kilo                           : \t  \(student.weight) kg")
                            Divider()
                            Text("Hedef                          : \t  \(student.goal ?? "hedef eklenmedi")")
                            Divider()
                            Text("Cinsiyet                     : \t \(student.gender == 0 ? "Erkek" : "Kadın")")
                            Divider()
                            Text("Doğum Tarihi            : \t \(formatDate(isoDate:student.birthDate))")
                        }
                        .font(.subheadline)
                    }
                    .frame(width: screenWidth * 5 / 6)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.secondarySystemBackground)))
                    .padding(.horizontal)
                    
                    
                    Divider()
                    HStack{
                        Text("Antrenman ve Diyet Planlarını Tasarla")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                    }
                    .padding(.leading)
                    
                    HStack{
                        Spacer()
                        
                        NavigationLink {
                            StudentWorkoutView(viewModel: viewModel, student: student)
                        } label: {
                            LottieItem(text: "Antrenman", lottie: "https://lottie.host/9f89854b-1c46-48d3-ba18-a00b23455157/GKg9GEfX6B.json")
                        }

                        
                        
                        Spacer()
                        NavigationLink {
                            StudentDietView(viewModel: viewModel, student: student)
                        } label: {
                            LottieItem(text: "Diyet", lottie: "https://lottie.host/e62589b7-38c6-41d8-b1e6-c73e68e153b8/vnRXxHAmIO.json")
                        }

                        
                        
                        Spacer()
                        
                    }
                    
                    Divider()
                    
                    VStack{
                        HStack {
                            Text("Öğrenci Gelişim Görüntüle")
                                .font(.system(size: 18))
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .padding(.leading)
                        
                        HStack {
                            Spacer()
                            NavigationLink {
                                WeeklyProgressResultView(subscriptionId: student.id)
                                    
                            } label: {
                                LottieItem(text: "Sonuçları Gör ", lottie: "https://lottie.host/248099fd-2c28-43ec-b2b0-83bba10cb00c/T7u4E3L6aH.json")
                            }

                           
                            Spacer()
                        }
                    }
                    
                    
                  
                }
            }
            .navigationTitle("Öğrenci Detay Sayfası")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchWorkoutPlan(subscriptionId: "\(student.id)")
                viewModel.fetchDietPlan(subscriptionId: "\(student.id)")
                print(student.endDate)
            }
            .padding()
        }
    }
}

#Preview {
    StudentDetailView(student: Student(id: "2", memberId: "2", endDate: "11/21", amount: 5500, height: 180, weight: 80, firstName: "İmat", lastName: "Gokaslan", gender: 0, birthDate: "15/08", photoPath: "", goal: "Bölgesel Yağ Yakımı"))
}


/*
Divider()
HStack {
    Spacer()
    NavigationLink {
        AntrenorWorkoutPlanView(student: student)
            .navigationBarBackButtonHidden(true)
    } label: {
        Text("Yeni bir antrenman programı ekle")
            .padding()
            .font(.system(size: 15))
            .clipShape(Rectangle())
            .background(.gray)
            .cornerRadius(10)
            .foregroundColor(.white)
    }
    Spacer()
}
.padding(.horizontal)

// Workout Planları Gösterimi
VStack(alignment: .leading, spacing: 10) {
    Text("Antrenman Planları")
        .fontWeight(.semibold)
        .font(.headline)
    
    if viewModel.isLoading {
        ProgressView("Antrenman planları yükleniyor...")
    } else if viewModel.workoutPlan.isEmpty {
        Text("Henüz antrenman planı yok.")
            .foregroundColor(.gray)
    } else {
        ForEach(viewModel.workoutPlan, id: \.id) { workout in
            
NavigationLink {

WeeklyWorkoutPlanView( workout: workout)
.navigationBarBackButtonHidden(true)
            }
        label: {
VStack(alignment: .leading, spacing: 8) {
HStack {
Text(workout.title)
.font(.headline)



Spacer()
Button {
    withAnimation {
       
        if let index = viewModel.workoutPlan.firstIndex(where: { $0.id == workout.id }) {
            viewModel.workoutPlan.remove(at: index)
        }
    }
    
    viewModel.deleteWorkoutPlan(id: workout.id)
} label: {
    Image(systemName: "trash")
}

}
Text(workout.description)
.font(.subheadline)
.foregroundColor(.gray)
HStack {
Text("Başlangıç: \(workout.formattedStartDate)")
Spacer()
Text("Bitiş: \(workout.formattedEndDate)")
}
.font(.footnote)
.foregroundColor(.secondary)
}
.padding()
.background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.systemBackground)))
.shadow(radius: 2)
}

}
    }
}
.padding()

Divider()

HStack {
    Spacer()
    NavigationLink {
        AntrenorDietPlanView(student: student)
            .navigationBarBackButtonHidden(true)
    } label: {
        Text("Yeni bir Diyet programı ekle")
            .padding()
            .font(.system(size: 15))
            .clipShape(Rectangle())
            .background(.gray)
            .cornerRadius(10)
            .foregroundColor(.white)
    }
    Spacer()
}
.padding(.horizontal)



VStack(alignment: .leading, spacing: 10) {
    Text("Diyet Planları")
        .fontWeight(.semibold)
        .font(.headline)
    
    if viewModel.isLoading2 {
        ProgressView("Diyet planları yükleniyor...")
    } else if viewModel.dietPlan.isEmpty {
        Text("Henüz diyet planı yok.")
            .foregroundColor(.gray)
    } else {
        ForEach(viewModel.dietPlan, id: \.id) { diet in
            
NavigationLink {
DietDaysView(workout: diet)
    .navigationBarBackButtonHidden(true)
            }
        label: {
VStack(alignment: .leading, spacing: 8) {
HStack {
Text(diet.title)
.font(.headline)



Spacer()
Button {
    withAnimation {
       
        if let index = viewModel.dietPlan.firstIndex(where: { $0.id == diet.id }) {
            viewModel.dietPlan.remove(at: index)
        }
    }
    
    viewModel.deleteDietPlan(id: diet.id)
} label: {
    Image(systemName: "trash")
}

}
Text(diet.description)
.font(.subheadline)
.foregroundColor(.gray)
HStack {
Text("Başlangıç: \(diet.formattedStartDate)")
Spacer()
Text("Bitiş: \(diet.formattedEndDate)")
}
.font(.footnote)
.foregroundColor(.secondary)
}
.padding()
.background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.systemBackground)))
.shadow(radius: 2)
}
}
}
}
.padding()
 */
