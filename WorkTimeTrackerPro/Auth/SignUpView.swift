//
//  SignUpView.swift
//  WorkTimeTrackerPro
//
//  Created by Bootan Majeed on 2023-12-12.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabaseInternal


struct User {
    let uid: String
    let email: String
    let fullName: String
    let address: String
    let phoneNumber: String
}

extension User {
    func toDictionary() -> [String: Any] {
        return [
            "uid": uid,
            "email": email,
            "fullName": fullName,
            "address": address,
            "phoneNumber": phoneNumber
        ]
    }
}

struct SignUpView: View {
    
    
    @State private var email = ""
    @State private var password = ""
    @State private var fullName = ""
    @State private var address = ""
    @State private var phoneNumber = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.lightgreen.opacity(0.8) // Set the background color here
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        Text(" Sign Up")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding()
                        Spacer()
                    }
                    TextField("Email", text: $email)
                        .padding(.all, 15)
                        .frame(width: 350, height: 50, alignment: .center)
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(10)
                        .keyboardType(.emailAddress)
                        .padding()
                      
                    
                    SecureField("Password", text: $password)
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 15)
                        .frame(width: 350, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(10)
                      
                    
                    TextField("Full Name", text: $fullName)
                        .padding(.all, 15)
                        .frame(width: 350, height: 50, alignment: .center)
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(10)
                        .keyboardType(.default)
                        .padding()
                    
                    TextField("Address", text: $address)
                        .padding(.all, 15)
                        .frame(width: 350, height: 50, alignment: .center)
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(10)
                        .keyboardType(.alphabet)
                
                    
                    TextField("Phone Number", text: $phoneNumber)
                        .padding(.all, 15)
                        .frame(width: 350, height: 50, alignment: .center)
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(10)
                        .keyboardType(.phonePad)
                        .padding()
                    
                    Button(action: signUp) {
                        Text("Sign Up")
                            .foregroundStyle(Color.white)
                            .frame(width: 350, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color.black)
                            .cornerRadius(15)
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 10)
                    }
                }
            }
        }
    }
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Sign up failed: \(error.localizedDescription)")
            } else if let authResult = authResult {
                print("Sign up successful.")
                
                // Create a user object with the additional information
                let user = User(uid: authResult.user.uid,
                                email: email,
                                fullName: fullName,
                                address: address,
                                phoneNumber: phoneNumber)
                
                // Save the user information to Firebase Realtime Database
                let userRef = Database.database().reference().child("users").child(authResult.user.uid)
                userRef.setValue(user.toDictionary())
                
                // Redirect to another view or perform any other actions
            }
        }
    }

    
    
    
}

#Preview {
    SignUpView()
}
