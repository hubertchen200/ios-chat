import Foundation

struct UserData: Codable {
    let email: String
    let firstname: String
    let lastname: String
    let username: String
}

class UserSignModel: ObservableObject {
    @Published var currentUser: UserData?
    @Published var isLoading = false
    @Published var error: String?

    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        isLoading = true
        error = nil

        guard let url = URL(string: "https://user.hubertchen200.site/signin") else {
            error = "Invalid URL"
            isLoading = false
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let bodyData = ["email": email, "password": password]
        guard let body = try? JSONSerialization.data(withJSONObject: bodyData, options: []) else {
            error = "Invalid body data"
            isLoading = false
            return
        }
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.error = error.localizedDescription
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    self?.error = "Invalid response"
                    return
                }
                
                switch httpResponse.statusCode {
                case 200:
                    if let data = data {
                        do {
                            let decodedResponse = try JSONDecoder().decode(UserSignModelResponse.self, from: data)
                            if decodedResponse.status == "success", let userData = decodedResponse.data {
                                self?.currentUser = userData
                                completion(true)
                            } else {
                                self?.error = decodedResponse.error ?? "Unexpected response format"
                                completion(false)
                            }
                        } catch {
                            self?.error = "Error decoding response: \(error.localizedDescription)"
                            completion(false)
                        }
                    }
                case 401:
                    self?.error = "Invalid credentials"
                    completion(false)
                default:
                    self?.error = "Unexpected status code: \(httpResponse.statusCode)"
                    completion(false)
                }
            }
        }.resume()
    }
}

// The response structure should match your API's response
struct UserSignModelResponse: Codable {
    let status: String
    let data: UserData?
    let error: String?
}
