//
//  FoundationsAdiView.swift
//  PawMatch
//
//  Created by uvminstaller on 12/03/26.
//

import SwiftUI

struct FoundationsAdiView: View {
    
    @State private var reportText = ""
    @State private var showConfirmation = false
    
    var body: some View {
        
        
        ScrollView {
            
            VStack(spacing: 25) {
                
                Image(systemName: "cross.case.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.green)
                
                Text("Animal Protection")
                    .font(.title2)
                    .bold()
                
                Text("If you see animal abuse or pet in danger, you can report it here. Your report may help protect animals in need.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Describe the situation")
                        .font(.headline)
                    
                    TextField("Write your report here...", text: $reportText, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                }
                
                Button {
                    
                    reportText = ""
                    showConfirmation = true
                } label: {
                    
                    Text("Submit Report")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                
                Link("Visit Animal Protection Website",
                     destination: URL(string: "https://www.aspca.org/")!)
            }
            .padding()
        }
        .navigationTitle("Foundations & Aid")
        
        .alert("Report sent", isPresented: $showConfirmation) {
            Button("Ok", role: .cancel) {}
        } message: {
            Text("Thank you for your helping protect animals.")
        }
    }
}
