//
//  StartView.swift
//  WorkTimeTrackerPro
//
//  Created by Bootan Majeed on 2023-11-26.
//

import SwiftUI
import Firebase

struct StartView: View {
    
    @State var isLoggedin = false
    
    var body: some View {
        
        VStack{
            if isLoggedin {
                ContentView()
            }else{
                AuthenticationView()
            }
        }
        .onAppear(){
            _ = Auth.auth().addIDTokenDidChangeListener{
                auth, user in
                
                if Auth.auth().currentUser == nil{
                    isLoggedin = false
                }else{
                    isLoggedin = true
                    
                }
            }
        }
        
        
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
