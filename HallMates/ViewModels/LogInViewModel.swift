//
//  LogInViewModel.swift
//  HallMates
//
//  Created by Adeoluwa Olokesusi on 5/16/24.
//

import Foundation
import FirebaseAuth

class LogInViewModel: ObservableObject {
    @Published var  email = ""
    @Published var  password = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func login() {
        guard validate() else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Please fill all fields."
            return false
        }
            
            // email@foo.com
            guard email.contains("@") && email.contains(".edu") else {
                errorMessage = "Enter a valid school email."
                return false
            }
            
            return true
    }
    
}
