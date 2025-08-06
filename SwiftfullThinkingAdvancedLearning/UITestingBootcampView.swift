//
//  UITestingBootcampView.swift
//  SwiftfullThinkingAdvancedLearning
//
//  Created by Akram Husseini on 02/07/2025.
//

import SwiftUI


class UITestingBootcampViewModel: ObservableObject {
    
    let placeholderText: String = "Add the name..."
    @Published var textFieldText: String = ""
    @Published var currentUserIsSignedin: Bool
    
    init(currentUserIsSignedin: Bool) {
        self.currentUserIsSignedin = currentUserIsSignedin
    }
    
    func signupButtonPressed() {
        guard !textFieldText.isEmpty else { return }
        currentUserIsSignedin = true
    }
    
}

struct UITestingBootcampView: View {
    
    @StateObject private var vm: UITestingBootcampViewModel
    
    init(currentUserIsSignedin: Bool) {
        _vm = StateObject(wrappedValue: UITestingBootcampViewModel(currentUserIsSignedin: currentUserIsSignedin))
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.black]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            ZStack {
                if vm.currentUserIsSignedin {
                    SignedInHomeView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .trailing))
                }
                
                if !vm.currentUserIsSignedin {
                    singupLayer
                        .transition(.move(edge: .leading))
                }
            }
            
        }
    }
}

#Preview {
    UITestingBootcampView(currentUserIsSignedin: true)
}

extension UITestingBootcampView {
    
    
    private var singupLayer: some View {
        VStack {
            TextField(vm.placeholderText, text: $vm.textFieldText)
                .font(.headline)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .accessibilityIdentifier("SignupTextField")
            
            Button(action: {
                withAnimation {
                    vm.signupButtonPressed()
                }
            }, label: {
                Text("Sign up")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            })
            .accessibilityIdentifier("SignupButton")
            
            
        }
        .padding()
    }
    
}


struct SignedInHomeView: View {
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                Button(action: {
                    showAlert.toggle()
                }) {
                    Text("Show welcome alert")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .accessibilityIdentifier("ShowAlertButton")
                .alert(isPresented: $showAlert, content: {
                    return Alert(title: Text("Welcome to the App"))
                })
                
                NavigationLink(
                    destination: Text("Destination"),
                    label: {
                        Text("Navigate")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                .accessibilityIdentifier("NavigationLinkToDestination")
                
            }
            .padding()
            .navigationTitle("Welcome")
        }
    }
    
}
