//
//  AntrenorAnasayfa.swift
//  StayFit
//
//  Created by İmat Gökaslan on 19.10.2024.
//

import SwiftUI

struct AntrenorAnasayfa: View {
    @ObservedObject var viewModel = AntrenorAnasayfaViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.students) { student in
                NavigationLink(destination: StudentDetailView(student: student)) {
                    StudentRowView(student: student)
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



#Preview {
    AntrenorAnasayfa()
}
