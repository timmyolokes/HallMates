//
//  LogInView.swift
//  HallMates
//
//  Created by Adeoluwa Olokesusi on 5/15/24.
//

import SwiftUI

struct LogInView: View {
    
    @StateObject var viewModel = LogInViewModel()
    @State private var isPasswordVisible = false

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
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                    
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
                        TextField("School Email Address", text: $viewModel.email)
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
                                .frame(width: 160, height: 40)
                                .autocapitalization(.none)
                                .autocorrectionDisabled()
                            } else {
                                SecureField("Password", text: $viewModel.password)
                                    .frame(width: 160, height: 40)
                                    .autocapitalization(.none)
                                    .autocorrectionDisabled()
                            }
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                    .foregroundColor(.gray)
                            }
                            .offset(x: 120)

                        }
                        
                        Button {
                            viewModel.login()
                            
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.pink]), startPoint: .leading, endPoint: .trailing))

                                Text("Log In")
                                    .foregroundColor(.blue)
                                    .bold()

                            }
                        }.padding()

                    }.scrollContentBackground(.hidden)
                    
                    //Divider()
                    
                    
                    VStack {
                        NavigationLink("Create A New Account", destination: SignUpView())
                            //.navigationBarBackButtonHidden(true)

                    }.foregroundColor(.black)
                    
                    
                }
            }.background(Color.base)
        }

    }
}

#Preview {
    LogInView()
}
