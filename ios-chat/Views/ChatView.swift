import SwiftUI

struct ChatView: View {
    // Example chat messages with sender and content
    @State private var messages = [
        ("John", "Hey, how's it going?"),
        ("You", "Pretty good! How about you?"),
        ("John", "Hey, how's it going?"),
        ("You", "AFfdsaPretty good! How about you?"),
        ("John", "fdsaHey, how's it going?"),
        ("You", "fdsaPretty good! How about you?"),
        ("John", "fdsaHey, how's it going?"),
        ("You", "Prfdsaetty good! How about you?"),
        ("John", "Hfdsaey, how's it going?"),
        ("You", "Prefdsatty good! How about you?"),
        ("John", "Hefdsafy, how's it going?"),
        ("You", "Prefdsatty good! How about you?"),
        ("John", "Hefdsay, how's it going?"),
        ("You", "Pretfdsaty good! How about you?"),
        ("John", "Heyfdsa, how's it going?"),
        ("You", "Pretcxzcty good! How about you?"),
        ("John", "Hey,ew how's it going?"),
        ("You", "Prettdy good! How about you?"),
        ("John", "Hey, hdsafow's it going?"),
        ("You", "Pretty gofdsod! How about you?"),
        ("John", "Hey, hofdsaw's it going?"),
        ("You", "Pretty good! How about you?"),
        ("John", "Hey, hofsaw's it going?"),
        ("You", "Pretty gofdsaod! How about you?"),
        ("John", "Hey, how's it going?"),
        ("You", "Pretty gfdasood! How about you?"),
        ("John", "Hey, hfdsaow's it going?"),
        ("You", "Pretty gofdsaod! How about you?"),
        ("John", "Hey, how'fdsas it going?"),
        ("You", "Pretty goofsad! How about you?"),
        ("John", "I'm doing wfell, thanks for asking.")
    ]
    
    @State private var newMessage = ""
    
    var body: some View {
        VStack {
            // Chat messages list
            ScrollView {
                LazyVStack {
                    ForEach(messages, id: \.1) { message in
                        ChatBubble(sender: message.0, content: message.1)
                            .padding(.vertical, 4)
                    }
                }
            }
            
            // Message input field and send button
            HStack {
                TextField("Enter your message", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading, 10)
                
                Button(action: {
                    sendMessage()
                }) {
                    Text("Send")
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .disabled(newMessage.isEmpty) // Disable button if no message
                .padding(.trailing, 10)
            }
            .padding(.bottom, 10)
        }
        .navigationTitle("Chat")
    }
    
    // Function to send a message
    func sendMessage() {
        if !newMessage.isEmpty {
            messages.append(("You", newMessage)) // Add the new message to the list
            newMessage = "" // Clear the input field
        }
    }
}

// A chat bubble that displays messages with sender and receiver styles
struct ChatBubble: View {
    var sender: String
    var content: String
    
    var body: some View {
        HStack {
            if sender == "You" {
                Spacer() // Align "You" messages to the right
            }
            
            VStack(alignment: sender == "You" ? .trailing : .leading) {
                // Align sender name based on whether it's "You" or someone else
                Text(sender)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(sender == "You" ? .trailing : .leading, 10)
                
                // Message content bubble
                Text(content)
                    .padding()
                    .background(sender == "You" ? Color.blue : Color.green.opacity(0.7))
                    .cornerRadius(10)
                    .foregroundColor(sender == "You" ? .white : .black)
            }
            
            if sender != "You" {
                Spacer() // Align receiver's messages to the left
            }
        }
        .padding(sender == "You" ? .leading : .trailing, 40) // Adjust padding for sender/receiver alignment
        .padding(.horizontal, 10)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
