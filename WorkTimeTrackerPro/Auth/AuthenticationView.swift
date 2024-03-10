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
    @State private var showAlert = false
    @State private var alertMessage = ""

    
    
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
                    .padding(.top, 200)
                
                
                VStack {              //main Stack
                    LottieView(name: "loginanima", loopMode: .loop)
                        .scaleEffect(0.45)
                        .frame(height: 220)
                        .padding(.top)
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
                        resetPassword()
                    }, label: {
                        Text("Forgot my password?")
                            .foregroundColor(.white)
                    })

                    Spacer()
               
                    Button(action: {
                        isSignUpViewPresented = true
                    }, label: {
                        Text("New here? Sign Up")
                    })
                    .foregroundColor(.white)
                    .sheet(isPresented: $isSignUpViewPresented, content: {
                                        SignUpView()
                                    })
                    
                    
                    
                }
                .padding()

            }.alert(isPresented: $showAlert) {
                Alert(
                    title: Text("WorK Time Tracker"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
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
    
    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                showAlert = true
                alertMessage = "failed: \(error.localizedDescription)"
                print("Failed to send password reset email: \(error.localizedDescription)")
            } else {
                showAlert = true
                alertMessage = "Check your mail box to reset your password"
                print("Password reset email sent successfully.")
            }
        }
    }
        
        func signIn() {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    showAlert = true
                    alertMessage = "Sign in failed: \(error.localizedDescription)"
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
