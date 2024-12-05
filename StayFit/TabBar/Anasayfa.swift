//
//  Anasayfa.swift
//  StayFit
//
//  Created by İmat Gökaslan on 7.10.2024.
//

import SwiftUI
let feedback = UIImpactFeedbackGenerator(style: .medium)

var deneme: [Trainer] = [
    .init(id: "1", kisiAd: "Ahmet", profileUrl: "hoca", kisiSoyad: "Yılmaz", kisiTel: "05555555555", kisiBoy: 1.80, kisiKilo: 75.0, kisiEmail: "ahmetyilmaz@example.com", bio: "Deneyimli fitness eğitmeni.", monthlyRate: 150.0, rate: 4.8, yearsOfExperience: 10, createdDate: "2023-01-01"),
    .init(id: "2", kisiAd: "Mehmet", profileUrl: "hoca", kisiSoyad: "Kaya", kisiTel: "05553334444", kisiBoy: 1.85, kisiKilo: 78.0, kisiEmail: "mehmetkaya@example.com", bio: "Uzman pilates hocası.", monthlyRate: 120.0, rate: 4.5, yearsOfExperience: 8, createdDate: "2022-05-01"),
    .init(id: "3", kisiAd: "Ayşe", profileUrl: "logo", kisiSoyad: "Demir", kisiTel: "05554445555", kisiBoy: 1.65, kisiKilo: 60.0, kisiEmail: "aysedemir@example.com", bio: "Yoga eğitmeni.", monthlyRate: 130.0, rate: 4.9, yearsOfExperience: 12, createdDate: "2020-09-15"),
    .init(id: "4", kisiAd: "Elif", profileUrl: "diyet", kisiSoyad: "Çelik", kisiTel: "05556667777", kisiBoy: 1.70, kisiKilo: 65.0, kisiEmail: "elifcelik@example.com", bio: "Kardiyo uzmanı.", monthlyRate: 140.0, rate: 4.7, yearsOfExperience: 6, createdDate: "2021-06-10"),
    .init(id: "5", kisiAd: "Ali", profileUrl: "bcaa", kisiSoyad: "Er", kisiTel: "05557778888", kisiBoy: 1.75, kisiKilo: 72.0, kisiEmail: "alier@example.com", bio: "Bodybuilding ve güç antrenörü.", monthlyRate: 160.0, rate: 4.6, yearsOfExperience: 9, createdDate: "2019-11-21")
]


struct Anasayfa: View {
    @ObservedObject var viewmodel = ProfileViewViewModel()
    var diyet : Meal?
    @State var videos: [VideoModel] = Bundle.main.decode("videos.json")
    @State var videos1: [VideoModel] = Bundle.main.decode("videos1.json")
    @ObservedObject var dietProgram = BeslenmeViewModel()
    @State private var selectedDay: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // Gün adını tam almak için (Pazartesi, Salı, vb.)
        formatter.locale = Locale(identifier: "tr_TR") // Türkçe gün adları için
        return formatter.string(from: Date())
    }()
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack{
                    //MARK: - HEADER
                    HStack(spacing:20){
                        if let photoPath = viewmodel.userProfile?.photoPath {
                            AsyncImage(url: URL(string: photoPath)) { image in
                                image.resizable()
                                    .clipShape(Circle())
                                    .frame(width: 50, height: 50)
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                    .shadow(radius: 5)
                                    .padding(.leading)
                            } placeholder: {
                                ProgressView()
                            }
                        } else {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.gray)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .padding(.leading)
                        }
                        

                       
                        
                        VStack(alignment:.leading,spacing:3){
                            Text("Merhaba \(viewmodel.userProfile?.firstName ?? "kullanıcı")")
                                .fontWeight(.semibold)
                            CustomText()
                            
                        }
                       Spacer()
                
                        NavigationLink {
                            Calendarr()
                        } label: {
                            Image(systemName: "calendar")
                                .foregroundColor(.black)
                                .font(.system(size: 30))
                                .padding()
                        }

       
                    }
                    
                    CoverImageView()
                        .frame(height: 300)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                    
                    HStack(){
                        Text("Günün Diyet Planı")
                            .font(.title2)
                            .bold()
                            .multilineTextAlignment(.leading)
                            .padding(.leading)
                        Spacer()
                    }
                    
                
                    /*ScrollView(.horizontal, showsIndicators: false) {
                               HStack(spacing: 10) { // Öğeler arasında boşluk
                                   if let meals = dietProgram.program[selectedDay] {
                                       // Her bir öğünü listele
                                       ForEach(meals)  { meal in
                                           HStack {
                                           
                                               DiyetItem(diyet: meal)
                                                   .padding(.bottom,50)
                                               
                                           }
                                           .padding()
                                             
                                       }
                                   }//: Loop
                               } //: HStack
                               
    
                           }
                    .padding(.top,-10)
                    .offset(y:-15)
                     */
   
                    HStack(){
                        Text("Personel Traniers")
                            .font(.title2)
                            .bold()
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    
                    .padding(.leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                               HStack(spacing: 10) { // Öğeler arasında boşluk
                                   ForEach(deneme){ index in
                                       
                                       NavigationLink {
                                           TrainerDetailView(trainer: index)
                                       } label: {
                                           TrainersItem(trainer: index) // DiyetItem bileşenini çağır
                                               .frame(width: 200, height: 220)
                                               .padding(.horizontal,-5)
                                       }

                                       
                                           
                                   } //: Loop
                               } //: HStack
                               .padding(.trailing)
    
                           }
                    .padding(.top,-10)
                    .padding(.leading,10)
                    .offset(y:-15)
                    
                    
                    HStack(){
                        Text("Motivasyon Videoları")
                            .font(.title2)
                            .bold()
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    
                    .padding(.leading)
                    
                    ScrollView(.horizontal,showsIndicators: false) {
                        HStack {
                            ForEach(videos) { item in
                                
                                NavigationLink(destination: VideoPlayerView(videoSelected: "motivasyon-\(item.id)", videoTitle: item.name)) {
                                        VideoListItemView(video: item)
                                            .padding(.vertical,8)
                                    }
                                
                            }
                        }
                    }
                    
                    
                    
                    
                    HStack(){
                        Text("Populer Antrenman Programları")
                            .font(.title2)
                            .bold()
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    .padding(.leading)
                    
                    ScrollView(.horizontal,showsIndicators: false) {
                        HStack {
                            ForEach(videos1) { item in
                                
                                NavigationLink(destination: VideoPlayerView(videoSelected: "yararlivideolar-\(item.id)", videoTitle: item.name)) {
                                        VideoListItemView(video: item)
                                            .padding(.vertical,8)
                                            
                                    }
                                
                            }
                        }
                    }
                    
                    
                    
                    HStack(spacing:30){
                        NavigationLink {
                            Calendarr()
                        } label: {
                            LottieItem(text: "Antrenman", lottie: "https://lottie.host/9e0df46d-db11-4dfa-b82c-d3094c11706c/3Bv20Qk2mr.json")
                                .padding(.trailing,5)
                                .foregroundColor(.black)
                        }

                        
                        
                        NavigationLink {
                            MainTabView(activeTab: .antrenor)
                        } label: {
                            LottieItem(text: "Antrenörün", lottie: "https://lottie.host/2386d88f-e4e3-45c7-871c-f4b81d091602/Qng1wbwGBz.json")
                                .foregroundColor(.black)
                        }

                        
                        


                    }
                    
                    
                    Spacer()
                }
            }
            .onAppear(){
                viewmodel.fetchUserProfile()
            }
            
            
        }
    }
}

#Preview {
    Anasayfa()
}
