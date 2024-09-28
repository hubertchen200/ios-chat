import SwiftUI

struct ContentView: View {
    @StateObject private var loginViewModel = LoginViewModel() // Initialize the view model

    var body: some View {
        if loginViewModel.isLoggedIn {
            MainView() // Navigate to MainView after login
        } else {
            LoginView(loginViewModel: loginViewModel)
        }
    }
}


#Preview {
    ContentView()
}
