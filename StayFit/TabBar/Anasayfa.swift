//
//  Anasayfa.swift
//  StayFit
//
//  Created by İmat Gökaslan on 7.10.2024.
//

import SwiftUI

let feedback = UIImpactFeedbackGenerator(style: .medium)


struct Anasayfa: View {
    @StateObject var viewmodel = ProfileViewViewModel()
   
    @State var videos: [VideoModel] = Bundle.main.decode("videos.json")
    @State var videos1: [VideoModel] = Bundle.main.decode("videos1.json")
    @ObservedObject var dietProgram = BeslenmeViewModel()
    @ObservedObject var TodayDiyet = DietListModelView()
    @State private var selectedDay: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
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
                    
                    
                    
                    
                    
                    if TodayDiyet.TodayDietMeals.isEmpty{
                        
                    }else {
                        HStack(){
                            Text("Günün Diyet Planı")
                                .font(.title2)
                                .bold()
                                .multilineTextAlignment(.leading)
                                .padding(.leading)
                            Spacer()
                        }
                        .padding(.top,10)
                        VStack {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    // Tüm öğünleri birleştir ve mealType'e göre sırala
                                    let allMeals = TodayDiyet.groupedDietMeals.values.flatMap { $0 }
                                    let sortedMeals = allMeals.sorted(by: { $0.mealType < $1.mealType })
                                    
                                    ForEach(sortedMeals, id: \.id) { diet in
                                        NavigationLink(
                                            destination: DietMealDetailView(meal: diet)
                                                .navigationBarBackButtonHidden(true)
                                        ) {
                                            DiyetItem(diyet: diet)
                                                .padding(.bottom, 20)
                                                .padding(.horizontal,5)
                                        }
                                        .padding(.bottom,7)
                                        
                                    }
                                }
                            }
                            .padding(.vertical, 10)
                        }
                        .frame(height:250)
                    }
    
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
   
                    /*HStack(){
                        Text("Personel Traniers")
                            .font(.title2)
                            .bold()
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    .padding(.leading)
                     */
                    /*
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
                     */
                    
                    
                    HStack(){
                        Text("Motivasyon Videoları")
                            .font(.title2)
                            .bold()
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    .padding(.top)
                    .padding(.leading)
                    
                    
                    
                    ScrollView(.horizontal,showsIndicators: false) {
                        HStack {
                            ForEach(videos) { item in
                                
                                NavigationLink(destination: VideoPlayerView(videoSelected: "motivasyon-\(item.id)", videoTitle: item.name)) {
                                        VideoListItemView(video: item)
                                            .padding(.vertical,0)
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
                TodayDiyet.GetTodayDiets()
            }
            
            
        }
    }


#Preview {
    Anasayfa()
}
