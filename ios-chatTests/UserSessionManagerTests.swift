import XCTest
@testable import ios_chat // Replace with the actual name of your app's module

class UserSessionManagerTests: XCTestCase {

    let testUserSession = UserSession(
        email: "test@example.com",
        firstname: "John",
        lastname: "Doe",
        username: "johndoe"
    )
    
    override func setUp() {
        super.setUp()
        // Ensure that Keychain is clean before each test
        UserSessionManager.delete()
    }
    
    override func tearDown() {
        // Clean up Keychain after each test
        UserSessionManager.delete()
        super.tearDown()
    }
    
    // Test saving UserSession to Keychain
    func testSaveUserSession() {
        UserSessionManager.save(session: testUserSession)
        
        // Retrieve the saved session and verify it matches the test session
        if let retrievedSession = UserSessionManager.retrieve() {
            XCTAssertEqual(retrievedSession.email, testUserSession.email, "Saved email should match")
            XCTAssertEqual(retrievedSession.firstname, testUserSession.firstname, "Saved first name should match")
            XCTAssertEqual(retrievedSession.lastname, testUserSession.lastname, "Saved last name should match")
            XCTAssertEqual(retrievedSession.username, testUserSession.username, "Saved username should match")
        } else {
            XCTFail("Failed to retrieve saved session.")
        }
    }
    
    // Test retrieving UserSession from Keychain
    func testRetrieveUserSession() {
        // Save session first
        UserSessionManager.save(session: testUserSession)
        
        // Retrieve the session
        if let retrievedSession = UserSessionManager.retrieve() {
            XCTAssertEqual(retrievedSession.email, testUserSession.email, "Email should match")
        } else {
            XCTFail("User session was not retrieved correctly.")
        }
    }
    
    // Test deleting UserSession from Keychain
    func testDeleteUserSession() {
        // Save session first
        UserSessionManager.save(session: testUserSession)
        
        // Now delete the session
        UserSessionManager.delete()
        
        // Try to retrieve the session, it should be nil
        let retrievedSession = UserSessionManager.retrieve()
        XCTAssertNil(retrievedSession, "User session should be nil after deletion.")
    }
}
