//
//  ProfileView.swift
//  HallMates
//
//  Created by Adeoluwa Olokesusi on 5/15/24.
//

import SwiftUI

//class Profile: Identifiable, ObservableObject {
//    let id: UUID
//    @Published var name: String
//    @Published var image: Image
//    @Published var notificationCount: Int
//    @Published var yearMajor: String
//    @Published var classes: [String]
//    @Published var interests: [String]
//    @Published var organizations: [String]
//
//    init(id: UUID = UUID(), name: String, image: Image, notificationCount: Int, yearMajor: String, classes: [String] = []) {
//        self.id = id
//        self.name = name
//        self.image = image
//        self.notificationCount = notificationCount
//        self.yearMajor = yearMajor
//        self.classes = classes
//        self.interests = []
//        self.organizations = []
//    }
//
//    func addInterest(_ interest: String) {
//        interests.append(interest)
//    }
//
//    func addOrganization(_ org: String) {
//        organizations.append(org)
//    }
//
//    func addClass(_ classToAdd: String) {
//        classes.append(classToAdd)
//    }
//}
//
//struct ProfileView: View {
//    @EnvironmentObject var profileVM: ProfileViewModel  // Assume ProfileViewModel exists with an @Published var profiles
//
//    let profile: Profile
//    
//    var body: some View {
//        NavigationLink(destination: ChatView(profile: profile).environmentObject(profileVM)) {
//            ZStack(alignment: .topTrailing) {
//                VStack {
//                    profile.image
//                        .resizable()
//                        .aspectRatio(CGSize(width: 1200, height: 900), contentMode: .fill)
//                        .scaledToFit()
//                        .frame(width: 150, height: 112.5, alignment: .center)
//                        .clipped()
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                    
//                    Text(profile.name)
//                        .font(.title3)
//                        .lineLimit(2)
//                        .padding(4)
//                }
//                .background(Color(UIColor.systemBackground))
//                .cornerRadius(10)
//                .shadow(radius: 5)
//                
//                // Notification badge
//                if profile.notificationCount > 0 {
//                    Text("\(profile.notificationCount)")
//                        .font(.caption)
//                        .foregroundColor(.white)
//                        .padding(8)
//                        .background(Color.red)
//                        .clipShape(Circle())
//                        .offset(x:11, y: -15) // Adjust the position of the badge
//                }
//            }
//            .padding(.top, 0) // Remove padding here to adjust the gap
//            .padding(.leading, 3)
//        }.buttonStyle(PlainButtonStyle())
//    }
//}
//
//struct UniqueProfileView: View {
//    let profile: Profile
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            profile.image
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 200, height: 200)
//                .clipShape(Circle())
//                .overlay(Circle().stroke(Color.blue, lineWidth: 4))
//            
//            Text(profile.name)
//                .font(.largeTitle)
//                .padding(.bottom, 10)
//            
//            Text("Messages: \(profile.notificationCount)")
//                .font(.headline)
//            
//            // Add more customized details about the profile here
//            // For example, a list of interests, a bio, etc.
//            
//            Spacer()
//        }
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            // The toolbar can be customized to have more personalization
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Menu("Actions") {
//                    Button("View Photos", action: { })
//                    Button("Settings", action: { })
//                    // More actions here
//                }
//            }
//        }
//    }
//}
//
//
//struct ProfilesGridView: View {
//    @EnvironmentObject var profileVM: ProfileViewModel  // Assume ProfileViewModel exists with an @Published var profiles
//
//    // Define the layout for the grid
//    let columns = [
//        GridItem(.flexible()),
//        GridItem(.flexible()),
//        // Add more columns as needed, or adjust the spacing and alignment
//    ]
//    
//    var body: some View {
//        // We wrap ScrollView in NavigationStack to provide navigation capability.
//        
//        NavigationStack {
//            
//            ScrollView {
//                LazyVGrid(columns: columns, spacing: 10) {
//                    ForEach(profileVM.profiles) { profile in
//                        ProfileView(profile: profile)
//                        .environmentObject(profileVM)
//                    }
//                }
//                .padding(.horizontal)
//            }
//        }.navigationTitle("My Hallmates")
//    }
//}

class Profile: Identifiable, ObservableObject {
    let id: UUID
    @Published var name: String
    @Published var image: Image
    @Published var notificationCount: Int
    @Published var year : Int
    @Published var major: String
    @Published var profileStatement: String
    @Published var classes: [String]
    @Published var interests: [String]
    @Published var organizations: [String]

    init(id: UUID = UUID(), name: String, image: Image, notificationCount: Int, year: Int, major: String, profileStatement: String, classes: [String] = [], interests: [String] = [],
         organizations: [String] = []) {
        self.id = id
        self.name = name
        self.image = image
        self.notificationCount = notificationCount
        self.year = year
        self.major = major
        self.profileStatement = profileStatement
        self.classes = classes
        self.interests = interests
        self.organizations = organizations
    }

    func addInterest(_ interest: String) {
        interests.append(interest)
    }

    func addOrganization(_ org: String) {
        organizations.append(org)
    }

    func addClass(_ classToAdd: String) {
        classes.append(classToAdd)
    }
}

struct ProfileView: View {
    @EnvironmentObject var profileVM: ProfileViewModel
    let profile: Profile
    
    var body: some View {
        NavigationLink(destination: ChatView(profile: profile).environmentObject(profileVM)) {
            ZStack(alignment: .topTrailing) {
                VStack {
                    profile.image
                        .resizable()
                        .aspectRatio(CGSize(width: 1200, height: 900), contentMode: .fill)
                        .scaledToFit()
                        .frame(width: 150, height: 112.5, alignment: .center)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Text(profile.name)
                        .font(.title3)
                        .lineLimit(2)
                        .padding(4)
                }
                .background(Color(UIColor.systemBackground))
                .cornerRadius(10)
                .shadow(radius: 5)
                
                // Notification badge
                if profile.notificationCount > 0 {
                    Text("\(profile.notificationCount)")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.red)
                        .clipShape(Circle())
                        .offset(x: 11, y: -15) // Adjust the position of the badge
                }
            }
            .padding(.top, 0) // Remove padding here to adjust the gap
            .padding(.leading, 3)
        }.buttonStyle(PlainButtonStyle())
    }
}
struct UniqueProfileView: View {
    let profile: Profile
    
    var body: some View {
        VStack(spacing: 20) {
            profile.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.blue, lineWidth: 4))
            
            Text(profile.name)
                .font(.largeTitle)
                .padding(.bottom, 10)
            
            Text("Messages: \(profile.notificationCount)")
                .font(.headline)
            
            // Add more customized details about the profile here
            // For example, a list of interests, a bio, etc.
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // The toolbar can be customized to have more personalization
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu("Actions") {
                    Button("View Photos", action: { })
                    Button("Settings", action: { })
                    // More actions here
                }
            }
        }
    }
}

struct ProfilesGridView: View {
    @EnvironmentObject var profileVM: ProfileViewModel
    
    // Define the layout for the grid
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        // Add more columns as needed, or adjust the spacing and alignment
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(profileVM.likedProfiles) { profile in
                        ProfileView(profile: profile)
                            .environmentObject(profileVM)
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("My Hallmates")
        }
    }
}




struct ProfilesGridView_Previews: PreviewProvider {
    static var previews: some View {
        let profileViewModel = ProfileViewModel(profiles: [
            Profile(id: UUID(), name: "Axel Freedman", image: Image("frog"), notificationCount: 4, year: 2025, major: "Economics", profileStatement: "I aspire to create annoying music", classes: ["ECON 101", "MATH 202", "HIST 303"], interests: ["Pickleball", "Tennis", "Cooking"], organizations: ["Wolverine Support Network", "French Speakers' Association", "Kid's Kitchen"]),
            Profile(id: UUID(), name: "Minnie Mouse", image: Image("minnie"), notificationCount: 1, year: 2026, major: "Math", profileStatement: "I aspire to run the multi-billion dollar Disney empire", classes: ["ECON 101", "HIST 303"], interests: ["Pickleball", "Tennis", "Cooking"], organizations: ["Wolverine Support Network", "French Speakers' Association", "Kid's Kitchen"]),
            Profile(id: UUID(), name: "Millie Freedman", image: Image("millie"), notificationCount: 2, year: 2025, major: "Art History", profileStatement: "I aspire to eat the most gummy bears", classes: ["ECON 101", "HIST 303"], interests: ["Pickleball", "Tennis", "Cooking"], organizations: ["Wolverine Support Network", "French Speakers' Association", "Kid's Kitchen"]),
            Profile(id: UUID(), name: "Howl Moving", image: Image("howl"), notificationCount: 3, year: 2026, major: "International Relations", profileStatement: "I aspire to find my heart", classes: ["ECON 101", "HIST 303"], interests: ["Pickleball", "Tennis", "Cooking"], organizations: ["Wolverine Support Network", "French Speakers' Association", "Kid's Kitchen"]),
            
        ]) // Pass an array of profiles here
        return ProfilesGridView()
            .environmentObject(profileViewModel)
    }
}


