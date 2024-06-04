//
//  SignUpViewModel.swift
//  HallMates
//
//  Created by Adeoluwa Olokesusi on 5/16/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}

extension Encodable {
    func asDictionary() -> [String: Any]{
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
        } catch {
            return [:]
        }
    }
}



class SignUpViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var  email = ""
    @Published var  password = ""
    
    @Published var errorMessage = ""

    
    init() {}
    
    func signup() {
        guard validate() else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error as NSError?, error.code == AuthErrorCode.emailAlreadyInUse.rawValue {
                self?.errorMessage = "This email is already in use."
                return
            }
            
            guard let userId = result?.user.uid else{
                return
            }
            self?.insertUserRecord(id: userId)
        }
    }
    
    private func insertUserRecord(id: String) {
        let newUser = User(id: id, name: name, email: email, joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Please fill all fields."
            return false
        }
        
        // email@foo.com
        guard email.contains("@") && email.contains(".edu") else {
            errorMessage = "Enter a valid school email."
            return false
        }
        
        guard password.count >= 6 else {
            errorMessage = "Password must have at least 6 characters."
            return false
        }
        
        return true
    }
}
