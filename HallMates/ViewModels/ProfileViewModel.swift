//
//  ProfileViewModel.swift
//  HallMates
//
//  Created by Adeoluwa Olokesusi on 5/20/24.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var profiles: [Profile]
    @Published var likedProfiles: [Profile] = []
    @Published var userProfile: Profile?  // Add a property for the user profile
    
    init(profiles: [Profile] = [], userProfile: Profile? = nil) {
        self.profiles = profiles
        self.userProfile = userProfile
    }
    
    func likeProfile(_ profile: Profile) {
        likedProfiles.append(profile)
    }
    
    func removeLikedProfile(_ profile: Profile) {
        likedProfiles.removeAll { $0.id == profile.id }
    }
    
    func commonInterests(with profile: Profile) -> [String] {
        guard let userProfile = userProfile else { return [] }
        return Array(Set(userProfile.interests).intersection(profile.interests))
    }
    
    func commonClasses(with profile: Profile) -> [String] {
        guard let userProfile = userProfile else { return [] }
        return Array(Set(userProfile.classes).intersection(profile.classes))
    }
    
    func commonOrganizations(with profile: Profile) -> [String] {
        guard let userProfile = userProfile else { return [] }
        return Array(Set(userProfile.organizations).intersection(profile.organizations))
    }
    
    func findMembers(withOrganization organization: String) -> [String] {
        likedProfiles.filter { $0.organizations.contains(organization) }
                .map { $0.name }
    }
    
    func updateName(for profileID: UUID, with newName: String) {
        if let index = profiles.firstIndex(where: { $0.id == profileID }) {
            profiles[index].name = newName
        } else if profileID == userProfile?.id {
            userProfile?.name = newName
        }
    }
    
    func addInterests(to profileID: UUID, interest: String) {
        if let index = profiles.firstIndex(where: { $0.id == profileID }) {
            profiles[index].addInterest(interest)
        } else if profileID == userProfile?.id {
            userProfile?.addInterest(interest)
        }
    }
    
    func addOrganizations(to profileID: UUID, organization: String) {
        if let index = profiles.firstIndex(where: { $0.id == profileID }) {
            profiles[index].addOrganization(organization)
        } else if profileID == userProfile?.id {
            userProfile?.addOrganization(organization)
        }
    }
    
    func addClasses(to profileID: UUID, classToAdd: String) {
        if let index = profiles.firstIndex(where: { $0.id == profileID }) {
            profiles[index].addClass(classToAdd)
        } else if profileID == userProfile?.id {
            userProfile?.addClass(classToAdd)
        }
    }
    
    func profile(for profileID: UUID) -> Profile? {
        return profiles.first(where: { $0.id == profileID }) ?? (profileID == userProfile?.id ? userProfile : nil)
    }
    
    func commonClasses(between profileID1: UUID, and profileID2: UUID) -> [String] {
        guard let profile1 = profile(for: profileID1),
              let profile2 = profile(for: profileID2) else {
            return []
        }
        
        let commonClasses = Set(profile1.classes).intersection(Set(profile2.classes))
        return Array(commonClasses)
    }
    
    func updateProfile(profile updatedProfile: Profile) {
        if let index = profiles.firstIndex(where: { $0.id == updatedProfile.id }) {
            profiles[index] = updatedProfile
        } else if updatedProfile.id == userProfile?.id {
            userProfile = updatedProfile
        }
    }
}

