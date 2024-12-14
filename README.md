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

## GET Activities
```
    @MainActor
    func loadActivities() async {
        print("DEBUG:: loadActivities() called") // Debug to check if the function is triggered
        do {
            let activities = try await repository.fetchAllActivities()
            
            print("DEBUG:: Activities fetched: \(activities)") // Check if activities are fetched
            self.activities = activities
        } catch {
            print("DEBUG:: Failed to load activities: \(error.localizedDescription)") // Debug error
            self.errorMessage = error.localizedDescription
        }
    }
```
