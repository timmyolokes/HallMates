//
//  ChatView.swift
//  HallMates
//
//  Created by Adeoluwa Olokesusi on 5/20/24.
//

import SwiftUI

struct ChatView: View {
    let profile: Profile
    @State private var inputText: String = ""
    @State private var messages: [Message] = [] // Assuming Message is your custom Identifiable type
    @EnvironmentObject var profileVM: ProfileViewModel // Assume ProfileViewModel exists with an @Published var profiles
    
    var body: some View {
        VStack {
            List {
                ForEach(messages) { message in // Assuming Message conforms to Identifiable
                    HStack {
                        Spacer() // Push the chat message to the right side if needed
                        Text(message.content) // Assuming Message has a content property of type String
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .foregroundColor(Color.white)
                    }
                }
            }
            .navigationTitle(profile.name)
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Menu {
                        NavigationLink(destination: UniqueProfileView(profile: profile)) {
                            Label("View Profile", systemImage: "person.crop.circle")
                        }
                        Button(role: .destructive) {
                            profileVM.removeLikedProfile(profile)
                        } label: {
                            Label("Block...", systemImage: "hand.raised")
                        }
                        Button(role: .destructive, action: { }) {
                            Label("Report...", systemImage: "exclamationmark.bubble")
                        }
                    } label: {
                        Label("More Options", systemImage: "ellipsis.circle")
                    }
                }
            }
            
            VStack {
                ProfileInfoView(title: "Common classes with \(profile.name):", items: profileVM.commonClasses(with: profile))
                ProfileInfoView(title: "Common interests with \(profile.name):", items: profileVM.commonInterests(with: profile))
                ProfileInfoView(title: "Common organizations with \(profile.name):", items: profileVM.commonOrganizations(with: profile))
            }
            Spacer()
            
            HStack {
                TextField("Type a message...", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: sendMessage) {
                    Text("Send")
                        .bold()
                }
                .padding()
            }
        }
    }
    
    func sendMessage() {
        if !inputText.isEmpty {
            messages.append(Message(content: inputText))
            inputText = "" // Clear the input field after sending the message
        }
    }
}

struct ProfileInfoView: View {
    var title: String
    var items: [String]
    
    var body: some View {
        if !items.isEmpty {
            VStack(alignment: .leading) {
                Text(title)
                    .fontWeight(.semibold)
                    .padding(.top)
                Text(items.joined(separator: ", "))
                    .padding(.bottom)
            }
            .padding([.horizontal])
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(8)
        }
    }
}

// Update this struct to match your data model.
struct Message: Identifiable {
    let id: UUID = UUID() // Unique identifier for each message
    let content: String
}

