# StravaKit

Strava Swift package for Strava API v3.

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/ferrufino)

## Setup

1. **Create an App in Strava Developers**  
   Visit [Strava Developers](https://www.strava.com/settings/api) to create an app.  
   Ensure the **Authorization Callback Domain** is set correctly.

   Example:  
   ![Authorization Callback Domain](https://github.com/user-attachments/assets/4a0cb9fc-89cc-432f-b45f-26acd613e71d)

2. **Update Info.plist**  
   Add the following keys to your `Info.plist`:

```
<key>LSApplicationQueriesSchemes</key>
    <array>
        <string>strava</string>
    </array>
```  
3. add CFBundleURLTypes
```
<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>CFBundleURLName</key>
			<string>com.gustavoferrufino.APPNAME</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>APPNAME</string>
			</array>
		</dict>
	</array>
```


3. Include StravaKit in Your Target
Go to your app target -> Build Phases -> **Link Binary With Libraries ** and ensure “StravaKit” is included.

# How to use this?
## Object creation
Sample Demo: https://github.com/ferrufino/StravaKitDemo

You could possibly create a DIContainer and in it define the object as follows: 
```
        let config = StravaConfig(
            clientId: "",
            clientSecret: "",
            redirectUri: "APPNAME://<Authorization callback domain just like in strava dev portal>",
            scopes: "read,activity:write,activity:read_all" // add permissions you want to request the user
        )
        let tokenStorage = KeychainTokenStorage()
        let authManager = StravaAuthManager(config: config, tokenStorage: tokenStorage)
        let repository = StravaRepository(authManager: authManager, webClient: StravaWebClient.shared)
```
## Authentication
The Service has access to AuthManager, where the key methods are:
```   
    private func authenticateUser() async {
        do {
            try await authManager.authorize()
            if let token = authManager.tokenStorage.getToken(), !token.isExpired {
                isAuthenticated = true
            } else {
                isAuthenticated = false
            }
        } catch {
            authError = error.localizedDescription
            isAuthenticated = false
        }
    }

    private func deauthorize() async {
        do {
            try await authManager.deauthorize()
            isAuthenticated = false
        } catch {
            print("Error during logout: \(error.localizedDescription)")
        }
    }
```
StravaService:
```
    public func login() async {
        try? await authManager.authorize()
    }
    
    public func logout() async {
        try? await authManager.deauthorize()
    }
    
    public func handleAuthResponse(url: URL) async throws -> OAuthToken {
        return try await authManager.handleAuthResponse(url: url)
    }
    
    public func isAuthenticated() async -> Bool {
        return await authManager.authenticated()
    }
```
## GET Activities or Routes
Extract from StravaService:
```
    /// Fetch all activities
    public func fetchActivities(page: Int = 1, perPage: Int = 30) async throws -> [Activity] {
        let token = try await authManager.getValidToken()
        return try await repository.fetchAllActivities(token: token, page: page, perPage: perPage)
    }

    /// Fetch all saved routes
    public func fetchSavedRoutes(page: Int = 1, perPage: Int = 30) async throws -> [Route] {
        let token = try await authManager.getValidToken()
        return try await repository.fetchSavedRoutes(token: token, page: page, perPage: perPage)
    }
```
