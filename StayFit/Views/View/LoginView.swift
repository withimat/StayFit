//
//  LoginView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 1.10.2024.
//

import SwiftUI
import LocalAuthentication

struct LoginView : View {
   // @State  private var username = ""
   // @State  private var password = ""
    @StateObject var viewmodel = LoginViewViewModel()
    @State  var visible : Bool = false
    @State  var visibleString = "eye.slash.fill"
    @State var isAnimating: Bool = false
    @State private var showAlert = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack(){
                //MARK: - Image
                
                Image("cover2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width-110)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : -100)
                    .cornerRadius(20)
                    .padding(.vertical)
                    .onAppear(){
                        withAnimation(.easeIn(duration: 1)) {
                            isAnimating.toggle()
                            
                        }
                    }
                    
                    //MARK: - LOGIN YAZISI
                HStack{
                    VStack(alignment: .leading,spacing: 12, content: {
                        
                        Text("Hoşgeldiniz")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            
                        
                        Text("Lütfen giriş yapınız..")
                            .foregroundColor(Color.white.opacity(0.5))
                        
                        
                        
                        
                    })
                    
                    Spacer(minLength: 0)
                    
                }
                .padding()
                
                HStack{
                    if !viewmodel.errorMessage.isEmpty{
                        Text(viewmodel.errorMessage)
                            .foregroundStyle(.red)
                    }

                }
                
                
                
                HStack(){
                    Image(systemName: "envelope")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    TextField("Email",text: $viewmodel.email)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        
                }
                .padding()
                .background(Color.white.opacity(viewmodel.email == "" ? 0.1 : 0.5))
                .cornerRadius(15)
                .padding(.horizontal)
                
                HStack(){
                    Image(systemName: "lock")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    if visible == false {
                        SecureField("Şifreniz",text: $viewmodel.password)
                            .autocapitalization(.none)
                    }
                        
                    else {
                        TextField("Şifreniz",text: $viewmodel.password)
                            .autocapitalization(.none)
                    }
                        
                        
                    
                        
                    Button(action: {
                        if visible == false {
                            visible.toggle()
                            visibleString = "eye.fill"
                            
                            
                        } else {
                            visible.toggle()
                            visibleString = "eye.slash.fill"
                        }
                        
                    }, label: {
                        Image(systemName: visibleString)
                            .foregroundColor(.white.opacity(0.8))
                            .font(.system(size: 18))
                    })
                        
                }
                .padding()
                .background(Color.white.opacity(viewmodel.password == "" ? 0.1 : 0.5))
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.top,10)
                
                
                //MARK: - BUTTON
            
                    
                BigButton(title: "Giriş Yap", action: {
                    showAlert = true
                    
                    feedback.impactOccurred()
                    viewmodel.login(role: "student") 
                }, color: .white)
                
                    
                    
          
                
                
                
                
                
                Button(action: {
                    
                }, label: {
                    Text("Şifremi unuttum")
                        .fontWeight(.medium)
                        .foregroundColor(.white.opacity(0.8))
                })
                .padding(.top,5)
                
                
            
                
            
                Spacer(minLength: 0)
                
                HStack(spacing: 6){
                    Text("Hesabınız yok mu ?")
                    NavigationLink(destination: {
                        RegisterView()
                    }, label: {
                        Text("Kaydol")
                            .foregroundColor(.white.opacity(0.8))
                    })
                    
                    
                    
                    
                    
                }
                .padding(.vertical)
                
                
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .foregroundColor(.white)
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
            .navigationTitle("Öğrenci Giriş Sayfası")
            .toolbarTitleDisplayMode(.inline)
            .background(Color("BG").opacity(0.7))
            
            .navigationDestination(isPresented: $viewmodel.isAuthenticated) {
                MainTabView()
                }
        }
       
    }
}

#Preview {
    LoginView()
}
