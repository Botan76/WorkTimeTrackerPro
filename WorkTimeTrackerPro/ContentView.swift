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
    @State var selectedIndex = 0
    @StateObject var vm = TimeDifferenceViewModel()
    var body: some View {
        
        
        ZStack {
            VStack {
                TabView(selection: $selectedIndex) {
                    
                    NavigationView {
                        HomeView(vm: vm)
                    }.tabItem() {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }.tag(0)
                    NavigationView {
                        TrackView(vm: vm)
                    }
                    .tabItem() {
                        Image(systemName: "list.bullet.rectangle.fill")
                        Text("Tracker")
                    }.tag(1)
                    NavigationView{
                        ProfileView()
                    }
                    .tabItem() {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }.tag(2)
                }.accentColor(Color.blue)
                 
                    .onChange(of: selectedIndex) { _ in
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
