//
//  SignUpView.swift
//  PawMatch
//
//  Created by uvminstaller on 16/02/26.
//

import SwiftUI
import SwiftData

struct SignUpView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    
    @State private var animateCard = false
    @State private var showError: Bool = false
    @State private var errorMessage = ""
    @State private var showSuccess: Bool = false
    
    
    var body: some View {
        ZStack {
            Color.pink.opacity(0.15)
                .ignoresSafeArea()
            ScrollView {
                
                VStack {
                    Spacer()
                    
                    VStack(spacing: 25) {
                        
                        Image("dogavatar")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 110)
                        
                        Text("CREATE AN ACCOUNT")
                            .font(.system(size: 30, weight: .heavy, design: .rounded))
                            .foregroundColor(.black)
                        
                        VStack(spacing: 14) {
                            
                            VStack(spacing: 12) {

                                TextField("First name", text: $firstName)
                                    .padding(12)
                                TextField("Last name", text: $lastName)
                                    .padding(12)
                                TextField("Email", text: $email)
                                    .keyboardType(.emailAddress)
                                    .textInputAutocapitalization(.never)
                                    .padding(12)
                                SecureField("Password", text: $password)
                                    .padding(12)
                            }
                            .padding()
                            .clipShape(RoundedRectangle(cornerRadius:12))

                            Button {
                                performSignUp()
                            } label: {
                                Text("Sign up")
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(
                                        LinearGradient(
                                            colors: [.pink, .orange],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 18))
                            }
                        }
                        .padding(30)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 28))
                        .padding(.horizontal, 25)
                        .opacity(animateCard ? 1 : 0)
                        .offset(y: animateCard ? 0 : 40)
                        .onAppear {
                            withAnimation(.easeOut(duration: 0.5)) {
                                animateCard = true
                            }
                        }
                        
                        HStack {
                            Text("Do you already have an account?")
                                .foregroundColor(.secondary)
                            Button("Log in") {
                                dismiss()
                            }
                            .fontWeight(.semibold)
                        }
                        .font(.footnote)
                        .padding(.top, 10)
                    }
                    
                    Spacer()
                }
            }
                if showSuccess {
                    VStack(spacing: 12) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 45))
                            .foregroundColor(.green)
                        
                        Text("Account created successfully!")
                            .font(.headline)
                        
                        Text("Welcome to Paw Match!")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(25)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 10)
                    .transition(.scale.combined(with: .opacity))
                }
            }
            .alert("Sign up error", isPresented: $showError) {
                Button("Ok", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
            .onAppear {
                animateCard = true
            }
        }
        
        func performSignUp() {
            
            email = email.trimmingCharacters(in: .whitespacesAndNewlines)
            firstName = firstName.trimmingCharacters(in: .whitespacesAndNewlines)
            lastName = lastName.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty {
                errorMessage = "Please fill in all fields."
                showError = true
                return
            }
            if !email.contains("@") || !email.contains(".") {
                errorMessage = "Please enter a valid email address."
                showError = true
                return
            }
            if password.count < 6 {
                errorMessage = "Password must be at least 6 characters long."
                showError = true
                return
            }
            
            let descriptor = FetchDescriptor<User>()
            
            do {
                let users = try modelContext.fetch(descriptor)
                
                if users.contains(where: { $0.email.lowercased() == email.lowercased() }) {
                    errorMessage = "An account with this email already exists."
                    showError = true
                    return
                }
            
            } catch {
                errorMessage = "An error occurred while fetching users."
                showError = true
                return
            }
            
            let newUser = User(
                firstName: firstName,
                lastName: lastName,
                email: email,
                password: password,
                subscriptionStatus: .free
            )
    
            modelContext.insert(newUser)
            
            do {
                try modelContext.save()
                
                withAnimation {
                    showSuccess = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    dismiss()
                }
                
            } catch {
                errorMessage = "An error occurred while saving the user."
                showError = true
            }
        }
    }
