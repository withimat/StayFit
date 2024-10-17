//
//  InsetFactView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 10.10.2024.
//


import SwiftUI

struct InsetFactView: View {
    let animal : Suplement
    var body: some View {
        Group {
            TabView{
                ForEach(animal.fact,id: \.self) { item in
                    Text(item)
                }
            }
            .tabViewStyle(PageTabViewStyle())
           .frame(minWidth: 148,idealWidth: 168,maxHeight: 180)
        }//:Group
    }
}

#Preview {
    InsetFactView(animal: Suplement(id: "l-karnitin", name: "L-Karnitin", headline: "L-Karnitin, yağ asitlerinin enerjiye dönüşümünü destekleyen bir amino asittir.", description: "L-Karnitin, yağ asitlerinin mitokondrilere taşınmasına yardımcı olarak enerji üretimini destekleyen bir amino asittir. Bu, özellikle yağ yakımını artırmak ve egzersiz performansını iyileştirmek amacıyla kullanılır. L-Karnitin takviyeleri, genellikle sporcular ve kilo kontrolü yapmak isteyen kişiler tarafından kullanılır. Ayrıca, enerji seviyelerini artırabilir ve fiziksel performansı destekleyebilir. L-Karnitin genellikle sıvı, kapsül veya toz formunda bulunur ve egzersiz öncesinde veya sonrasında alınabilir.", link: "https://tr.wikipedia.org/wiki/L-Karnitin", image: "karnitin", fact: [
        "L-Karnitin, yağ asitlerinin enerjiye dönüşümünü destekler.",
        "Yağ yakımını artırabilir ve egzersiz performansını iyileştirebilir.",
        "Enerji seviyelerini artırabilir ve fiziksel performansı destekleyebilir.",
        "Genellikle egzersiz öncesi veya sonrası alınır."
      ]))
}
