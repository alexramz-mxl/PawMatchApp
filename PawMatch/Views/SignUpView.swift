//
//  SignUpView.swift
//  PawMatch
//
//  Created by uvminstaller on 16/02/26.
//

import SwiftUI

struct SignUpView: View {
    
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    
    
    var body: some View {
        
        VStack {
            Text("Create an Account")
                .font(.title)
                .bold()
            
            TextField("Type your first name", text: $firstName)
                .textFieldStyle(.roundedBorder)
            
            TextField("Type your last name", text: $lastName)
                .textFieldStyle(.roundedBorder)
            
            TextField("Type your email", text: $email)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Type your password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            Button("Sign up"){
                performSignUp()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.pink)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
    
    func performSignUp() {
        
        if firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty {
            print("Please fill all the fields")
        } else {
            let newUser = User(
                firstName: firstName,
                lastName: lastName,
                email: email,
                password: password,
                subscriptionStatus: .free
            )
            
            modelContext.insert(newUser)
            
            print("The user was created: \(newUser.fullName), \(newUser.email) has been created successfully!")
            
            dismiss()
        }
    }
}
