//
//  CustomTabBar.swift
//  StayFit
//
//  Created by İmat Gökaslan on 7.10.2024.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var activeTab : Tab
    var body: some View {
        VStack(spacing:0){

            HStack(spacing:0){
                ForEach(Tab.allCases, id: \.rawValue){tab in
                    Image(tab.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35,height: 35)
                        .offset(y : offset(tab))
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.5,dampingFraction: 0.7,blendDuration: 0.7)){
                                activeTab = tab
                            }
                            
                        }
                        .frame(maxWidth: .infinity)
                        
                }
            }
            .padding(.top,12)
            .padding(.bottom,20)
            .offset(y: 20)
            
        }
        .padding(.bottom, safeArea.bottom == 0 ? 20 : safeArea.bottom)
        .background(content: {
            ZStack{
                TabBarTopCurve()
                    .stroke(.black , lineWidth: 1)
                    .blur(radius: 1)
                    .padding(.horizontal,-10)
                    .offset(y:20)
                    
                
                TabBarTopCurve()
                    .fill(Color("turuncu").opacity(0.7).gradient)
                    .offset(y:20)
            }
        })
        .overlay(content: {
            GeometryReader { proxy in
                let rect = proxy.frame(in: .global)
                let width = rect.width
                let maxedWidth = width * 5
                let height = rect.height
                
                Circle()
                    .fill(.clear)
                    .frame(width: maxedWidth,height: maxedWidth)
                    .background(alignment: .top){
                        Rectangle()
                            .fill(.linearGradient(colors: [Color("TabBG"),Color("BG"),Color("BG")], startPoint: .top, endPoint: .bottom))
                            .frame(width: width,height: height)
                            .mask(alignment:.top){
                                Circle()
                                    .frame(width: maxedWidth,height: maxedWidth ,alignment: .top)
                            }
                    }
                    .overlay(content: {
                        Circle()
                            .stroke(.white , lineWidth: 0.2)
                            .blur(radius: 0.3)
                            
                    })
                    .frame(width: width)
                    .background() {
                        Rectangle()
                            .fill(.white)
                            .frame(width: 45,height: 4)
                            .glow(.white.opacity(0.5), radius: 50)
                            .glow(Color("blue").opacity(0.8), radius: 30)
                            .offset(y: -1.5)
                            .offset(y: -maxedWidth/2)
                            .rotationEffect(.init(degrees: calculateRotation(maxedWidth: maxedWidth/2, actualWidth: width, true)))
                            .rotationEffect(.init(degrees: calculateRotation(maxedWidth: maxedWidth/2, actualWidth: width)))
                    }
                    .offset(y: height/2.1  )
                
            }
            .overlay(alignment: .bottom) {
                Text(activeTab.rawValue)
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .offset(y: safeArea.bottom == 0 ? -15 : -safeArea.bottom+25)
            }
            .offset(y: 20)
        })
        
    }
    
    
    func calculateRotation(maxedWidth y: CGFloat, actualWidth : CGFloat, _ isInitial: Bool = false) -> CGFloat{
        let tabWidth = actualWidth / Tab.count
        
        let firstTabPositionX : CGFloat = -(actualWidth-tabWidth) / 2
        let tan = y / firstTabPositionX
        let radians = atan(tan)
        let degree = radians * 180 / .pi
        
        
        if isInitial {
            return -(degree + 90)
        }
        
        let x = tabWidth * activeTab.index
        let tan_ = y / x
        let radians_ = atan(tan_)
        let degree_ = radians_ * 180 / .pi
        
        
        
        
        return -(degree_ - 90)
        
    }
    
    
    
    func offset(_ tab: Tab) -> CGFloat {
        let totalIndices = Tab.count
        let currentIndex = tab.index
        let progress = currentIndex / totalIndices
        
        return progress < 0.5 ? (currentIndex * -10) : ((totalIndices - currentIndex-1) * -10)
    }
    
}


struct TabBarTopCurve: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let width = rect.width
            let height = rect.height
            let midWidth = rect.width / 2
            path.move(to: .init(x: 0, y: 5))
            
            
            path.addCurve(to: .init(x: midWidth, y: -20), control1: .init(x: midWidth/2, y: -20), control2: .init(x: midWidth, y: -20))
            
            path.addCurve(to: .init(x: width, y: 5), control1: .init(x: (midWidth + (midWidth/2)), y: -20), control2: .init(x: width, y: 5))
            
            path.addLine(to: .init(x: width, y: height))
            path.addLine(to: .init(x: 0, y: height))
            
            path.closeSubpath()
            
            
        }
    }
}
