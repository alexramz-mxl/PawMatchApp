//
//  LoginView.swift
//  PawMatch
//
//  Created by uvminstaller on 14/02/26.
//

import SwiftUI
import SwiftData

struct LoginView: View {
    @Environment(\.modelContext) var modelContext
    
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var errorMessage: String = ""
    @State private var invalidLogin: Bool = false
    
    @State private var isLoggedIn: Bool = false
    @State private var userId: UUID?
    
    @State private var animateGradient: Bool = false
    @State private var isButtonPressed: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack{
                LinearGradient(
                    colors: [Color.pink.opacity(0.4), Color.orange.opacity(0.4)],
                    startPoint: animateGradient ? .topLeading : .bottomTrailing,
                    endPoint: animateGradient ? .bottomTrailing : .topLeading
                )
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 5).repeatForever(autoreverses: true), value: animateGradient)
                .onAppear {
                    animateGradient = true
                }
                Image(systemName: "pawprint.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350)
                    .foregroundColor(.white.opacity(0.2))
                    .rotationEffect(.degrees(25))
                
                
                VStack(spacing: 25) {
                    Spacer()
                    
                    Text("PawMatch")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                    
                    VStack(spacing: 15) {
                        TextField("Email:", text: $email)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .textFieldStyle(.roundedBorder)
                        
                        SecureField("Password:", text: $password)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        performLogin()
                    }) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .background(LinearGradient(colors: [Color.pink, Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .scaleEffect(isButtonPressed ? 1.1 : 1)
                            .opacity(isButtonPressed ? 0.8 : 1)
                    }
                    .onTapGesture {
                        withAnimation {
                            isButtonPressed.toggle()
                        }
                    }
                    .padding(.horizontal)
                    
                    NavigationLink("You're not registered? Let's create an account!") {
                        SignUpView()
                    }
                    .foregroundColor(.white)
                    .padding(.top, 10)
                    
                    Spacer()
                }
                .padding()
            }
            .alert("Login error", isPresented: $invalidLogin) {
                Button("ok", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
            .navigationDestination(isPresented: $isLoggedIn) {
                ProfileView(user: User(
                        firstName: "Demo",
                        lastName: "User",
                        email: email,
                        password: password
                    )
                )
            }
        }
    }
    
    func performLogin() {
        
        if email.isEmpty || password.isEmpty {
            errorMessage = "Please fill in all fields."
            invalidLogin = true
        } else {
            isLoggedIn = true
            userId = UUID()
        }
    }
}
