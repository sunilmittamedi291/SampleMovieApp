//
//  UserLoginPage.swift
//  MoviesSampleApp
//
//  Created by Sunil Kumar on 12/02/24.
//

import SwiftUI

struct UserLoginPage: View {
    @State var phoneNumber: String = ""
    @State private var isPhoneNumberValid = true
    @State private var showError = false
    private let characterLimit = 10
    @State private var isShowingNextScreen = false
    var body: some View {
        NavigationStack {
            ZStack {
                Circle().fill(.red.opacity(0.1))
                VStack {
                    Text("welcome!").font(.largeTitle).bold()
                    Text("Enter Your MobileNumber").font(.caption).opacity(0.8).padding(.bottom)
                    TextField("Mobile", text: $phoneNumber).padding().frame(width: 300, height: 50).background(.red.opacity(0.1)).cornerRadius(20.0).onChange(of: phoneNumber) { newValue in
                        if phoneNumber.count >= characterLimit {
                            
                            phoneNumber = String(phoneNumber.prefix(characterLimit))
                            isPhoneNumberValid = true
                            
                        }
                        
                    }.accessibilityIdentifier("enterMobileNumber")
                    
                    if showError  {
                        Text("Invalid mobile number")
                            .foregroundColor(.red)
                            .padding()
                    } else if !isPhoneNumberValid  {
                        Text("Mobile number should be 10 digits")
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    Button("Login") {
                        if isValidPhoneNumber(phoneNumber) {
                            isShowingNextScreen = true
                            // Perform login logic
                            print("Login successful")
                        } else {
                            if phoneNumber.count != 10 {
                                isPhoneNumberValid = false
                            } else {
                                showError = true
                            }
                            
                        }
                        
                        
                    }.padding().frame(width: 300, height: 50).foregroundColor(.white).background(.red).cornerRadius(20.0).accessibilityIdentifier("Login").navigationDestination(isPresented: $isShowingNextScreen) {
                        MoviesListView()
                    }
                    
                    
                    
                }
            }
        }
    }
    // Function to validate mobile number using regular expression
    private func isValidPhoneNumber(_ number: String) -> Bool {
        let phoneRegex = "^\\d{10}$" // Matches exactly 10 digits
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return predicate.evaluate(with: number)
    }
}

struct UserLoginPage_Previews: PreviewProvider {
    static var previews: some View {
        UserLoginPage()
    }
}
