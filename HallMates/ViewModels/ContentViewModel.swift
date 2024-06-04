//
//  ContentViewModel.swift
//  HallMates
//
//  Created by Adeoluwa Olokesusi on 5/17/24.
//

import Foundation
import FirebaseAuth

class ContentViewModel: ObservableObject {
    
    @Published var currentUserId: String = ""
    
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }

//    public var isSignedOut: Bool {
//        return !isSignedIn
//    }   
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            print("User signed out successfully")
        } catch {
            print(error)
        }
    }

}
