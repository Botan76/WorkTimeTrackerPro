//
//  ContentView.swift
//  WorkTimeTrackerPro
//
//  Created by Bootan Majeed on 2023-11-19.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State var userisloggedIn = false
    
    @StateObject var vm = TimeDifferenceViewModel()
    var body: some View {
        
        
        ZStack {
            VStack {
                TabView {
                    
                    NavigationView {
                        HomeView(vm: vm)
                    }.tabItem() {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    NavigationView {
                        TrackView(vm: vm)
                    }
                    .tabItem() {
                        Image(systemName: "list.bullet.rectangle.fill")
                        Text("Tracker")
                    }
                    ProfileView()
                        .tabItem() {
                            Image(systemName: "person.fill")
                            Text("Profile")
                        }
                }.accentColor(Color.blue)

            }            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
