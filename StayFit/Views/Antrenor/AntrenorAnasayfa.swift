//
//  AntrenorAnasayfa.swift
//  StayFit
//
//  Created by İmat Gökaslan on 19.10.2024.
//

import SwiftUI

struct AntrenorAnasayfa: View {
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "BG")
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "beyaz")!,.font : UIFont(name: "Pacifico-Regular" , size: 22)!]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
    @ObservedObject var viewModel = AntrenorAnasayfaViewModel()
    
    var body: some View {
        NavigationStack {
            VStack{
            List(viewModel.students) { student in
                NavigationLink(destination: StudentDetailView(student: student)) {
                    StudentRowView(student: student)
                    
                }
            }
        }
        .navigationTitle("Öğrencilerim")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchStudents()
        }
        }
    }
}

struct StudentRowView: View {
    let student: Student
    
    var body: some View {
        
        
        HStack(spacing: 20) {
            if let photoPath = student.photoPath, let url = URL(string: photoPath) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
            }
            
            VStack(alignment: .leading,spacing: 15) {
                HStack{
                    Text("\(student.firstName) \(student.lastName)")
                        .font(.headline)
                }
                
                HStack{
                    Text("Boy: \(student.height) cm \t Kilo: \(student.weight) kg")
                }
            }
        }
    }
}



#Preview {
    AntrenorAnasayfa()
}
