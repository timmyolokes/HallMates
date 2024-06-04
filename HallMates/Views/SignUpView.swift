//
//  SignUpView.swift
//  HallMates
//
//  Created by Adeoluwa Olokesusi on 5/15/24.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var viewModel = SignUpViewModel()
    @State private var isPasswordVisible = false

//    @State var name = ""
//    @State var  email = ""
//    @State var  password = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                VStack {
                    Image(.hallMatesLogo)
                        .resizable()
                        .scaledToFill()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .offset(y:10)
                    
                    Text("HallMates")
                        .font(.title)
                        .foregroundColor(.clear)
                        .background(
                            GradientView(startColor: Color("Yellowish"), endColor: Color("Pinkish"), startPoint: .leading, endPoint: .trailing)
                        )
                        .mask(Text("HallMates").font(.title))
                        .italic()
                        .bold()
                        .padding()
                    
                    
                    Form {
                        if !viewModel.errorMessage.isEmpty {
                            Text(viewModel.errorMessage).foregroundStyle(.red)
                        }
                        TextField("Full Name", text: $viewModel.name)
                            .frame(width: 200, height: 40)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                        
                        
                        TextField("Email Address", text: $viewModel.email)
                            .frame(width: 200, height: 40)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                        
//                        SecureField("Password", text: $viewModel.password)
//                            .frame(width: 200, height: 40)
//                            .autocapitalization(.none)
//                            .autocorrectionDisabled()
                        
                        HStack {
                            if isPasswordVisible {
                                TextField("Password",
                                          text:
                                            $viewModel.password)
                                .frame(width: 180, height: 40)
                                .autocapitalization(.none)
                                .autocorrectionDisabled()
                            } else {
                                SecureField("Password", text: $viewModel.password)
                                    .frame(width: 180, height: 40)
                                    .autocapitalization(.none)
                                    .autocorrectionDisabled()
                            }
                            Spacer()
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                    .foregroundColor(.gray)
                            }

                        }

                        
                        Button {
                            viewModel.signup()
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.pink]), startPoint: .leading, endPoint: .trailing))
                                
                                Text("Sign Up")
                                    .foregroundColor(.blue)
                                    .bold()
                                
                            }
                        }.padding()
                        
                    }.scrollContentBackground(.hidden)
                    
                    
//                    VStack {
//                        NavigationLink("Already have an account?", destination: LogInView())
//                            //.navigationBarBackButtonHidden(true)
//                        
//                    }.foregroundColor(.black)
                    
                    
                }
            }.background(Color.base)
        }


        
    }
}

#Preview {
    SignUpView()
}
