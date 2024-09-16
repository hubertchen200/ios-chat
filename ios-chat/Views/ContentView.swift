import SwiftUI

struct ContentView: View {
    @State private var isUserLoggedIn: Bool = false

    var body: some View {
        if isUserLoggedIn {
            MainView() // Navigate to MainView after login
        } else {
            LoginView(isUserLoggedIn: $isUserLoggedIn) // Pass binding to LoginView
        }
    }
}


#Preview {
    ContentView()
}
