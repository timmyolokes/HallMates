//
//  MyProfile.swift
//  HallMates
//
//  Created by Adeoluwa Olokesusi on 5/20/24.
//

import SwiftUI

struct MyProfileView: View {
    @StateObject var viewModel = ContentViewModel()
    @EnvironmentObject var profileVM: ProfileViewModel

    @State private var newInterest: String = ""
    @State private var newOrg: String = ""
    @State private var newClass: String = ""

    @State private var name: String = ""
    @State private var year: Int = 0
    @State private var major: String = ""
    @State private var profileStatement: String = ""


    private var yearBinding: Binding<String> {
           Binding<String>(
               get: { String(self.year) },
               set: {
                   if let value = Int($0) {
                       self.year = value
                   }
               }
           )
       }
    
    var body: some View {
        NavigationView {
            if let currentUserProfile = profileVM.userProfile {
                VStack {
                    currentUserProfile.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.blue, lineWidth: 4))
                        .padding()

                    TextField("Enter Name", text: $name)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .onAppear {
                            name = currentUserProfile.name
                            year = currentUserProfile.year
                            major = currentUserProfile.major
                            profileStatement = currentUserProfile.profileStatement
                        }
                        .onChange(of: name) { newValue in
                            profileVM.updateName(for: currentUserProfile.id, with: newValue)
                        }
                    
                    TextField("Enter Year", text: yearBinding)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .onChange(of: year) { newValue in
                            profileVM.updateYear(for: currentUserProfile.id, with: newValue)
                        }
                    TextField("Enter Profile Statement", text: $profileStatement)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .onChange(of: profileStatement) { newValue in
                            profileVM.updatePS(for: currentUserProfile.id, with: newValue)
                        }
                    List {
                        Section(header: Text("Interests")) {
                            ForEach(currentUserProfile.interests, id: \.self) { interest in
                                Text(interest)
                            }
                            HStack {
                                TextField("Add new interest", text: $newInterest)
                                Button(action: {
                                    if !newInterest.isEmpty {
                                        profileVM.addInterests(to: currentUserProfile.id, interest: newInterest)
                                        newInterest = ""
                                    }
                                }) {
                                    Image(systemName: "plus")
                                }
                            }
                        }

                        Section(header: Text("Organizations")) {
                            ForEach(currentUserProfile.organizations, id: \.self) { org in
                                Text(org)
                            }
                            HStack {
                                TextField("Add new organization", text: $newOrg)
                                Button(action: {
                                    if !newOrg.isEmpty {
                                        profileVM.addOrganizations(to: currentUserProfile.id, organization: newOrg)
                                        newOrg = ""
                                    }
                                }) {
                                    Image(systemName: "plus")
                                }
                            }
                        }

                        Section(header: Text("Classes")) {
                            ForEach(currentUserProfile.classes, id: \.self) { className in
                                Text(className)
                            }
                            HStack {
                                TextField("Add new class", text: $newClass)
                                Button(action: {
                                    if !newClass.isEmpty {
                                        profileVM.addClasses(to: currentUserProfile.id, classToAdd: newClass)
                                        newClass = ""
                                    }
                                }) {
                                    Image(systemName: "plus")
                                }
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    Spacer()
    
                    VStack {
                        Button("Log Out") {
                            viewModel.signOut()
                        }
                        .padding()
                        .foregroundColor(.red)
                    }
                }
                .padding()
                .navigationTitle("My Profile")
            } else {
                Text("No user profile available.")
                    .font(.largeTitle)
                    .padding()
            }
        }
    }
}

// MARK: - Previews
struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
            .environmentObject(ProfileViewModel(profiles: [
                Profile(id: UUID(), name: "Axel Freedman", image: Image("frog"), notificationCount: 4, year: 2025, major: "Economics", profileStatement: "I aspire to create annoying music", classes: ["ECON 101", "MATH 202", "HIST 303"], interests: ["Pickleball", "Tennis", "Cooking"], organizations: ["Wolverine Support Network", "French Speakers' Association", "Kid's Kitchen"]),
                Profile(id: UUID(), name: "Minnie Mouse", image: Image("minnie"), notificationCount: 1, year: 2026, major: "Math", profileStatement: "I aspire to run the multi-billion dollar Disney empire", classes: ["ECON 101", "HIST 303"], interests: ["Pickleball", "Tennis", "Cooking"], organizations: ["Wolverine Support Network", "French Speakers' Association", "Kid's Kitchen"]),
                Profile(id: UUID(), name: "Millie Freedman", image: Image("millie"), notificationCount: 2, year: 2025, major: "Art History", profileStatement: "I aspire to eat the most gummy bears", classes: ["ECON 101", "HIST 303"], interests: ["Pickleball", "Tennis", "Cooking"], organizations: ["Wolverine Support Network", "French Speakers' Association", "Kid's Kitchen"]),
                Profile(id: UUID(), name: "Howl Moving", image: Image("howl"), notificationCount: 3, year: 2026, major: "International Relations", profileStatement: "I aspire to find my heart", classes: ["ECON 101", "HIST 303"], interests: ["Pickleball", "Tennis", "Cooking"], organizations: ["Wolverine Support Network", "French Speakers' Association", "Kid's Kitchen"]),
                Profile(id: UUID(), name: "Mickey Mouse", image: Image("mickey"), notificationCount: 0, year: 2025, major: "Acting", profileStatement: "I aspire to make magic happen", classes: ["ECON 101", "HIST 303"], interests: ["Pickleball", "Tennis", "Cooking"], organizations: ["Wolverine Support Network", "French Speakers' Association", "Kid's Kitchen"]),
                Profile(id: UUID(), name: "Kevin Minion", image: Image("minion"), notificationCount: 5, year: 2032, major: "Mischief", profileStatement: "I aspire to cause damage to goods and property", classes: ["ECON 101", "HIST 303"], interests: ["Pickleball", "Tennis", "Cooking"], organizations: ["Wolverine Support Network", "French Speakers' Association", "Kid's Kitchen"]),
                Profile(id: UUID(), name: "Squidward Tentacles", image: Image("squid"), notificationCount: 10, year: 2026, major: "Statistics", profileStatement: "I aspire to be as annoying as possible", classes: ["ECON 101", "HIST 303"], interests: ["Pickleball", "Tennis", "Cooking"], organizations: ["Wolverine Support Network", "French Speakers' Association", "Kid's Kitchen"]),
                Profile(id: UUID(), name: "Dory Flipper", image: Image("dory"), notificationCount: 0, year: 2024, major: "Marine Biology", profileStatement: "I can't remember what I aspire to be", classes: ["ECON 101", "HIST 303"], interests: ["Pickleball", "Tennis", "Cooking"], organizations: ["Wolverine Support Network", "French Speakers' Association", "Kid's Kitchen"])
                // Add more profiles as needed
            ],
                                                          userProfile: Profile(name: "Bruno", image: Image("bruno"), notificationCount: 0, year: 2027, major: "Computer Engineering", profileStatement: "I aspire to work for a major software development firm", classes: ["ENG301", "PHYS202"], interests: ["Pickleball", "Tennis", "Cooking"], organizations: ["Wolverine Support Network", "French Speakers' Association", "Kid's Kitchen"])
            ))
    }
}



// Assuming your Profile model has a yearMajor property, add this method to your ProfileViewModel
extension ProfileViewModel {
    func updateYear(for profileID: UUID, with newYear: Int) {
        if let index = profiles.firstIndex(where: { $0.id == profileID }) {
            profiles[index].year = newYear
        }
    }
    func updateMajor(for profileID: UUID, with newMajor: String) {
        if let index = profiles.firstIndex(where: { $0.id == profileID }) {
            profiles[index].major = newMajor
        }
    }
    func updatePS(for profileID: UUID, with newPS: String) {
        if let index = profiles.firstIndex(where: { $0.id == profileID }) {
            profiles[index].profileStatement = newPS
        }
    }
}
