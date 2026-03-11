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
    @EnvironmentObject var session: SessionManager
    @Query private var users: [User]
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var errorMessage: String = ""
    @State private var invalidLogin: Bool = false
    
    @State private var animateGradient = false
    @State private var animatePaw: Bool = false
    
    var body: some View {
        NavigationStack {
                
                if session.currentUser == nil {
                    loginScreen
                } else {
                    HomeView(user: session.currentUser!)
                }
        }
    }
            
    var loginScreen: some View {
        ZStack() {
                    
                LinearGradient(
                    colors: [Color.pink.opacity(0.4), Color.orange.opacity(0.4)],
                    startPoint: animateGradient ? .topLeading : .bottomTrailing,
                    endPoint: animateGradient ? .bottomTrailing : .topLeading
                    )
                    .ignoresSafeArea()
                    .onAppear {
                        withAnimation(.easeInOut(duration: 10).repeatForever(autoreverses: true)) {
                            animateGradient = true
                        }
                    }
                
                    Image(systemName: "pawprint.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 170)
                        .foregroundColor(.white.opacity(0.3))
                        .rotationEffect(.degrees(35))
                        .offset(y: -300)
                    
                    VStack(spacing: 12) {
                        Spacer()
                        HStack{
                            Text("Paw Match")
                                .font(.system(size: 46, weight: .heavy, design: .rounded))
                            
                            Image(systemName: "heart.fill")
                                .font(.system(size: 12))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.pink, .red],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .offset(y: -2)
                        }
                        HStack() {
                            TextField("Email address", text: $email)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                        }
                        .padding(10)
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .padding(.horizontal, 20)
                        
                            HStack {
                            SecureField("Secret pawssword", text: $password)
                                .textInputAutocapitalization(.never)
                        }
                        .padding(10)
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .padding(.horizontal, 20)
                        
                        Button("Forgot password?") {
                            
                        }
                        .font(.footnote)
                        .foregroundColor(.black.opacity(0.3))
                        
                        loginButton
                        
                        NavigationLink("You're not registered? Let's create an account!") {
                            SignUpView()
                        }
                        .foregroundColor(.pink.opacity(0.5))
                        
                        Text("© All rights reserved 2026")
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.top, 20)
                        
                        Spacer()
                    }
                }
                .alert("Login error", isPresented: $invalidLogin) {
                    Button("ok", role: .cancel) { }
                } message: {
                    Text(errorMessage)
                }
            }

    var loginButton: some View {
        VStack(spacing: 12) {
            
            Button {
                performLogin()
            } label: {
                
                Image(systemName: "pawprint.fill")
                    .font(.system(size: 90))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.pink, .orange],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
            .scaleEffect(animatePaw ? 1.1 : 1)
            .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: animatePaw)
            .onAppear {
                animatePaw = true
            }
            .disabled(email.isEmpty || password.isEmpty)
            .opacity(email.isEmpty || password.isEmpty ? 0.5 : 1)
            
            Text("Tap the paw to enter")
                .font(.caption)
                .foregroundColor(.gray .opacity(0.5))
        }
        .padding(.top, 20)
    }
            func performLogin() {
                
                if email.isEmpty || password.isEmpty {
                    errorMessage = "Please fill in all fields."
                    invalidLogin = true
                    return
                }
                
                guard let user = users.first(where: {
                    $0.email.lowercased() == email.lowercased() &&
                    $0.passwordHash == User.hashPassword(password)
                }) else {
                    errorMessage = "Invalid email or password."
                    invalidLogin = true
                    return
                }
                
                session.login(user: user)
            }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
