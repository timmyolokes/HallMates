//
//  OrganizationView.swift
//  HallMates
//
//  Created by Adeoluwa Olokesusi on 5/20/24.
//

import SwiftUI
import SafariServices


struct OrganizationCardView: View {
    var organization: StudentOrganization
    @EnvironmentObject var profileVM: ProfileViewModel

    var body: some View {
        NavigationLink(destination: OrganizationDetailView(organization: organization).environmentObject(profileVM)) {
            VStack {
                Image(organization.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)

                Text(organization.name)
                    .font(.headline)
                    .padding(.top, 5)

                Text(organization.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.top, 2)

                Spacer()

                // You might remove this button or update its functionality as it might be redundant with the detail view.
                Button(action: {
                    if let url = URL(string: organization.url) {
                        let safariViewController = SFSafariViewController(url: url)
                        UIApplication.shared.windows.first?.rootViewController?.present(safariViewController, animated: true, completion: nil)
                    } else {
                        print("Invalid URL for organization: \(organization.name)")
                    }
                    print("Apply Now Tapped for: \(organization.name)")
                }) {
                    Text("Join/Apply Now")
                        .bold()
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .buttonStyle(PlainButtonStyle())
    }
}


struct MembersListView: View {
    var organization: StudentOrganization
    @EnvironmentObject var profileVM: ProfileViewModel
    
    var body: some View {
        VStack {
            Text("Members of \(organization.name)")
                .font(.largeTitle)
                .padding()
            
            List {
                ForEach(profileVM.findMembers(withOrganization: organization.name), id: \.self) { memberName in
                    Text(memberName)
                }
            }
        }
    }
}

struct OrganizationView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(sampleOrganizations) { organization in
                        OrganizationCardView(organization: organization)
                            .padding()
                    }
                }
            }
            .navigationTitle("Student Organizations")
        }
    }
}

struct StudentOrganization: Identifiable {
    var id: String { name }
    var name: String
    var description: String
    var imageName: String // The image name within your asset catalogue
    var url: String // The website URL of the organization

}

struct OrganizationDetailView: View {
    var organization: StudentOrganization
    @EnvironmentObject var profileVM: ProfileViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(organization.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 250)
                    .clipped()
                    .cornerRadius(12)

                VStack(alignment: .leading) {
                    Text(organization.name)
                        .font(.title)
                        .fontWeight(.bold)

                    Text(organization.description)
                        .font(.body)
                        .padding(.vertical)

                    // Here you might show upcoming events or more details about the organization.
                }
                .padding(.horizontal)
                VStack {
                    let orgMembers = profileVM.findMembers(withOrganization: organization.name)
                    if !orgMembers.isEmpty {
                        Text("Members you know: \(orgMembers.joined(separator: ", "))")
                            .padding()
                            .lineLimit(3)
                    }
                }
                Button(action: {
                    if let url = URL(string: organization.url) {
                        let safariViewController = SFSafariViewController(url: url)
                        UIApplication.shared.windows.first?.rootViewController?.present(safariViewController, animated: true, completion: nil)
                    } else {
                        print("Invalid URL for organization: \(organization.name)")
                    }
                }) {
                    Text("Join this Organization")
                        .foregroundColor(.white)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(organization.name)
        .navigationBarTitleDisplayMode(.inline)
        // If you have other toolbar items, add them here.
    }
}

let sampleOrganizations: [StudentOrganization] = [
    StudentOrganization(name: "Wolverine Support Network", description: "Help us run peer-led mental health support groups.", imageName: "WSN", url: "https://www.umichwsn.org/join"),
    StudentOrganization(name: "French Speakers Association", description: "Meet other francophone students.", imageName: "french", url: "https://maizepages.umich.edu/organization/french-speakers-association"),
    // Add more student organizations as needed
]

struct OrganizationView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationView().environmentObject(ProfileViewModel(profiles: [
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
                                                              userProfile: Profile(name: "Timmy", image: Image("timmy"), notificationCount: 0, year: 2027, major: "Computer Engineering", profileStatement: "I aspire to work for a major software development firm", classes: ["ENG 301", "PHYS 202",
                                                                                                                                                                                                                                                                                "MATH 202"], interests: ["Pickleball", "Tennis", "Cooking"], organizations: ["Wolverine Support Network", "French Speakers' Association", "Kid's Kitchen"])
                                                             ))
    }
}
