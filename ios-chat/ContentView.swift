import SwiftUI

struct ContentView: View {
    @StateObject var userSignModel = UserSignModel() // Initialize the model
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            // Show a loading indicator when sign-in is in progress
            if userSignModel.isLoading {
                ProgressView("Signing in...")
                    .padding()
            } else {
                Image(systemName: "lock.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding(.bottom, 20)
                // Login form
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    
               
                
                Button("Login") {
                    // Call the sign-in method with email and password
                    userSignModel.signIn(email: email, password: password)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                // Show error message if there’s an error
                if let error = userSignModel.error {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
            }

            // Show welcome message if logged in
            if let currentUser = userSignModel.currentUser {
                Text("Welcome, \(currentUser.firstname) \(currentUser.lastname)!")
                    .padding()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
