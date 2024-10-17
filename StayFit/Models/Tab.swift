//
//  Tab.swift
//  StayFit
//
//  Created by İmat Gökaslan on 7.10.2024.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case anasayfa = "Anasayfa"
    case antrenman = "Antrenman"
    case beslenme = "Beslenme"
    case antrenor = "Antrenor"
    case profil = "Profil"
    
    // Her sekmenin view'ini döndüren property (AnyView ile sarıldı)
    var view: AnyView {
        switch self {
        case .anasayfa:
            return AnyView(Anasayfa())
        case .antrenman:
            return AnyView(Antrenman())
        case .beslenme:
            return AnyView(Beslenme())
        case .antrenor:
            return AnyView(AntrenorSecim())
        case .profil:
            return AnyView(ProfileView())
        }
    }
    
    // Her sekmeye bir index vermek için kullanılan property
    var index: CGFloat {
        switch self {
        case .anasayfa: return 0
        case .antrenman: return 1
        case .beslenme: return 2
        case .antrenor: return 3
        case .profil: return 4
        }
    }
    
    // Sekme sayısını döndürmek için kullanılan property
    static var count: CGFloat {
        return CGFloat(Tab.allCases.count)
    }
}

 /*
  enum Tab: String, CaseIterable {
      case home = "home_icon"
      case search = "search_icon"
      case profile = "profile_icon"
      
      var view: some View {
          switch self {
          case .anasayfa:
              return Anasayfa()
          case .antrenman:
              return Antrenman()
          case .beslenme:
              return Beslenme()
          case .antrenor:
                return Antrenor()
          case .profile:
              return ProfileView()
          }
      }
      
      var index: CGFloat {
          switch self {
          case .home: return 0
          case .search: return 1
          case .profile: return 2
          }
      }
      
      static var count: CGFloat {
          return CGFloat(Tab.allCases.count)
      }
  }*/
