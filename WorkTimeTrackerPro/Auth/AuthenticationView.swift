//
//  AuthenticationView.swift
//  WorkTimeTrackerPro
//
//  Created by Bootan Majeed on 2023-11-19.
//

import SwiftUI
import Firebase


struct AuthenticationView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUpViewPresented = false
    
    
    
    var body: some View {
        ZStack {
            Color.darkgreen
                .ignoresSafeArea()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,  maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

            ZStack{
                
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.lightgreen, Color.darkgreen]), startPoint: .leading, endPoint: .trailing))
                
                
                
                    .background(Color.gray)
                    .frame(width: 375, height: 280)
                    .opacity(0.9)
                    .cornerRadius(18)
                    .blur(radius: 1)
                    .padding(.top, 230)
                
                
                VStack {              //main Stack
                    Image("logio")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 340, height: 180) //
                        .padding()
                    
                    Spacer()
//two Text Field
                    TextField("Email", text: $email)
                        .padding(.all, 15)
                        .frame(width: 350, height: 50, alignment: .center)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10)
                        .keyboardType(.emailAddress)
                        
                    
                    
                    SecureField("password", text: $password)
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 15)
                        .frame(width: 350, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10)
                    Divider()
//Button Login
                    Button(action: {
                        signIn()
                    }, label: {
                        Text("Login")
                            .foregroundStyle(Color.white)
                            .frame(width: 350, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color.black)
                            .cornerRadius(15)
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 10)
                    })

//Button SignUp
                    Button(action: {
                        isSignUpViewPresented = true
                    }, label: {
                        Text("New here? Sign Up")
                    })
                    .foregroundColor(.white)
                    .sheet(isPresented: $isSignUpViewPresented, content: {
                                        SignUpView() // Replace SignUpView with the actual view for sign up
                                    })
                    
                    Spacer()
               
                    
                    
                    
                    
                }
                .padding()

            }

        }
    }
    
    func signUp() {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    print("Sign up failed: \(error.localizedDescription)")
                } else {
                    print("Sign up successful.")
                }
            }
        }
        
        func signIn() {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    print("Sign in failed: \(error.localizedDescription)")
                } else {
                    print("Sign in successful.")
                }
            }
            
        }
}


struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
