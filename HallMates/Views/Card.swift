import SwiftUI

struct CardV2: View {
    @EnvironmentObject var profileVM: ProfileViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if !profileVM.profiles.isEmpty {
                    ProfileCard(profile: profileVM.profiles[0]) {
                        profileVM.profiles.remove(at: 0)
                    }
                } else {
                    Text("No more profiles")
                        .font(.largeTitle)
                        .padding()
                }
            }
            .navigationBarTitle("Explore")
        }
    }
}

struct ProfileCard: View {
    @EnvironmentObject var profileVM: ProfileViewModel
    let profile: Profile
    var onRemove: (() -> Void)? = nil
    
    @State private var offset: CGSize = .zero
    @State private var isSwiping: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                profile.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300)
                    .clipped()
                    .background(.blue)
                    .overlay(
                        VStack(alignment: .leading) {
                            Text(profile.name)
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.white)
                                .shadow(radius: 4)
                            Text(String(profile.year) + " " + profile.major)
                                .foregroundColor(.white)
                                .shadow(radius: 4)
                        }
                            .padding()
                        , alignment: .bottomLeading
                    )
                VStack {
                    Text("My Aspiration")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                    Text(self.profile.profileStatement)
                        .font(.body)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                }.padding(.top, 10)
                if !profileVM.commonInterests(with: profile).isEmpty {
                    VStack(alignment: .leading) {
                        Text("Interests")
                                               .font(.title2)
                                               .fontWeight(.bold)
                                               .padding(.bottom, 10)
                                           
                                           ScrollView(.horizontal, showsIndicators: false) {
                                               HStack(spacing: 15) {
                                                   ForEach(profile.interests, id: \.self) { interest in
                                                       Text(interest)
                                                           .padding(.horizontal)
                                                           .padding(.vertical, 5)
                                                           .background(profileVM.commonInterests(with: profile).contains(interest) ? Color.base : Color.gray)
                                                           .foregroundColor(.white)
                                                           .cornerRadius(5)
                                                   }
                                               }
                                           }
                                        
                                       }.padding()
                }
                
                if !profileVM.commonClasses(with: profile).isEmpty {
                    VStack(alignment: .leading) {
                        Text("Common Classes")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(profileVM.commonClasses(with: profile), id: \.self) { commonClass in
                                    Text(commonClass)
                                        .padding(.horizontal)
                                        .padding(.vertical, 5)
                                        .background(.base)
                                        .foregroundColor(.white)
                                        .cornerRadius(5)
                                }
                            }
                        }
                    }.padding()
                }
                
                if !profileVM.commonOrganizations(with: profile).isEmpty {
                    VStack(alignment: .leading) {
                        Text("Common Organizations")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(profileVM.commonOrganizations(with: profile), id: \.self) { organization in
                                    Text(organization)
                                        .padding(.horizontal)
                                        .padding(.vertical, 5)
                                        .background(Color.base)
                                        .foregroundColor(.white)
                                        .cornerRadius(5)
                                }
                            }
                        }
                    }.padding()
                }
                
                Spacer()
                HStack {
                    Button(action: {
                        // Handle dislike action
                        swipeOffScreen(to: .left)
                    }) {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
        
                    
                    Button(action: {
                        // Handle superlike action
                        swipeOffScreen(to: .right)
                    }) {
                        Image(systemName: "star.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.clear)
                            .overlay(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color("Yellowish"), Color("Pinkish")]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                                .mask(
                                    Image(systemName: "star.circle")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                )
                            )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 15)
            }
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
            .padding()
            .offset(x: offset.width, y: 0)
            .rotationEffect(.degrees(Double(offset.width / 20)))
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                        isSwiping = true
                    }
                    .onEnded { gesture in
                        if abs(gesture.translation.width) > 150 {
                            swipeOffScreen(to: gesture.translation.width > 0 ? .right : .left)
                        } else {
                            offset = .zero
                            isSwiping = false
                        }
                    }
            )
        }
    }
    
    private func swipeOffScreen(to direction: SwipeDirection) {
        if direction == .right {
            profileVM.likeProfile(profile)
        }
        offset = direction == .right ? CGSize(width: 1000, height: 0) : CGSize(width: -1000, height: 0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            onRemove?()
            offset = .zero
        }
    }
    
    private enum SwipeDirection {
        case left, right
    }
}

    
    struct CardViewPreview: PreviewProvider {
        static var previews: some View {
            CardV2().environmentObject(ProfileViewModel(profiles: [
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
