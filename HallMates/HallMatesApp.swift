//
//  HallMatesApp.swift
//  HallMates
//
//  Created by Adeoluwa Olokesusi on 5/15/24.
//

import FirebaseCore
import SwiftUI


@main
 struct HallMatesApp: App {


@StateObject var profileVM = ProfileViewModel(profiles: [
    Profile(id: UUID(), name: "Axel Freedman", image: Image("frog"), notificationCount: 4, year: 2025, major: "Economics", profileStatement: "I aspire to create annoying music", classes: ["ECON 101", "MATH 202", "HIST 303"], interests: ["Pickleball", "Tennis", "Cooking"], organizations: ["Wolverine Support Network", "French Speakers' Association", "Kid's Kitchen"]),
    Profile(id: UUID(), name: "Minnie Mouse", image: Image("minnie"), notificationCount: 1, year: 2026, major: "Math", profileStatement: "I aspire to run the multi-billion dollar Disney empire", classes: ["ECON 101", "HIST 303"], interests: ["Pickleball", "Tennis"], organizations: ["Wolverine Support Network", "French Speakers' Association", "Kid's Kitchen"]),
    Profile(id: UUID(), name: "Millie Freedman", image: Image("millie"), notificationCount: 2, year: 2025, major: "Art History", profileStatement: "I aspire to eat the most gummy bears", classes: ["ECON 101", "HIST 303"], interests: ["Tennis", "Cooking"], organizations: ["Wolverine Support Network", "French Speakers' Association", "Kid's Kitchen"]),
    Profile(id: UUID(), name: "Howl Moving", image: Image("howl"), notificationCount: 3, year: 2026, major: "International Relations", profileStatement: "I aspire to find my heart", classes: ["ECON 101", "HIST 303"], interests: ["Pickleball", "Tennis", "Cooking"], organizations: ["Wolverine Support Network", "French Speakers' Association", "Kid's Kitchen"]),
    Profile(id: UUID(), name: "Mickey Mouse", image: Image("mickey"), notificationCount: 0, year: 2025, major: "Acting", profileStatement: "I aspire to make magic happen", classes: ["ECON 101", "HIST 303"], interests: ["Pickleball", "Tennis", "Cooking"], organizations: ["Wolverine Support Network", "French Speakers' Association", "Kid's Kitchen"]),
    Profile(id: UUID(), name: "Kevin Minion", image: Image("minion"), notificationCount: 5, year: 2032, major: "Mischief", profileStatement: "I aspire to cause damage to goods and property", classes: ["ECON 101", "HIST 303"], interests: ["Pickleball", "Tennis", "Cooking"], organizations: ["Wolverine Support Network", "French Speakers' Association", "Kid's Kitchen"]),
    Profile(id: UUID(), name: "Squidward Tentacles", image: Image("squid"), notificationCount: 10, year: 2026, major: "Statistics", profileStatement: "I aspire to be as annoying as possible", classes: ["ECON 101", "HIST 303"], interests: ["Pickleball", "Tennis", "Cooking"], organizations: ["Wolverine Support Network", "French Speakers' Association", "Kid's Kitchen"]),
    Profile(id: UUID(), name: "Dory Flipper", image: Image("dory"), notificationCount: 0, year: 2024, major: "Marine Biology", profileStatement: "I can't remember what I aspire to be", classes: ["ECON 101", "PHYS 202","HIST 303"], interests: ["Pickleball", "Tennis", "Cooking"], organizations: ["Wolverine Support Network", "French Speakers' Association", "Kid's Kitchen"])
    // Add more profiles as needed
],
                                              userProfile: Profile(name: "Timmy", image: Image("timmy"), notificationCount: 0, year: 2027, major: "Computer Engineering", profileStatement: "I aspire to work for a major software development firm", classes: ["ENG 301", "PHYS 202", "MATH 202"], interests: ["Pickleball", "Tennis", "Cooking"], organizations: ["Wolverine Support Network", "French Speakers' Association", "Kid's Kitchen"])
)

     init() {
             FirebaseApp.configure()
         }
     
     var body: some Scene {
         WindowGroup {
             ContentView()
                 .environmentObject(profileVM)
         }
     }
}

struct UserProfileView: View {
@EnvironmentObject var profileVM: ProfileViewModel

var body: some View {
    if let userProfile = profileVM.userProfile {
        UniqueProfileView(profile: userProfile)
    } else {
        Text("No user profile available")
    }
}
}
