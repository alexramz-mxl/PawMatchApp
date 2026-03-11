//
//  AddPetView.swift
//  PawMatch
//
//  Created by uvminstaller on 06/03/26.
//

import SwiftUI
import SwiftData
import PhotosUI

struct AddPetView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var session: SessionManager
    var user: User
    @State private var name = ""
    @State private var breed = ""
    @State private var age = 1
    @State private var petDescription = ""
    @State private var selectedItem: PhotosPickerItem?
    @State private var imageData: Data?
    @State private var showSubscriptionAlert = false

    var maxPetsAllowed: Int {
        session.currentUser?.maxPetsAllowed ?? 3
    }
    
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 20) {
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images
                ) {
                    
                    if let data = imageData,
                       let uiImage = UIImage(data: data) {
                        
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    } else {
                        
                        Circle()
                            .fill(.gray.opacity(0.2))
                            .frame(width: 150, height: 150)
                            .overlay(
                                Image(systemName: "camera")
                                    .font(.title)
                            )
                    }
                }
                
                TextField("Your pet's name:", text: $name)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Breed:", text: $breed)
                    .textFieldStyle(.roundedBorder)
                
                Stepper("Age: \(age)", value: $age, in: 1...20)
                
                TextField("Description:", text: $petDescription)
                    .textFieldStyle(.roundedBorder)
                
                Button("Save your pet") {
                    savePet()
                }
                .buttonStyle(.borderedProminent)
            }
            
            .padding()
            .navigationTitle("Add pet")
            
            .alert("Pet limit reached", isPresented: $showSubscriptionAlert) {
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Free accounts can only add up to \(maxPetsAllowed) pets.")
            }
        }
            .onChange(of: selectedItem) { _, newItem in
                
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        imageData = data
                    }
                }
            }
        }
        func savePet() {
            
            guard let user = session.currentUser else { return }
                        
            if user.pets.count >= user.maxPetsAllowed {
                showSubscriptionAlert = true
                return
            }
            
            let newPet = Pet(
                name: name,
                breed: breed,
                age: age,
                petDescription: petDescription,
                imageData: imageData,
                owner: user
                )
                modelContext.insert(newPet)
                dismiss()
            
    }
}
