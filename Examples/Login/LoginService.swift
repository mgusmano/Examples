//import UIKit
//
//class LoginService: NSObject {
//    
//    // MARK: Properties
//    
//    internal let session:URLSession!
//    private var tokenInfo:OAuthInfo!
//    
//    
//    // MARK: Types
//    
//    struct OAuthInfo {
//        var token: String!
//        let tokenExpiresAt: NSDate!
//        let refreshToken: String!
//        let refreshTokenExpiresAt: NSDate!
//        
//        
//        // MARK: Initializers
//        
//        init(issuedAt: TimeInterval, refreshTokenIssuedAt: TimeInterval, tokenExpiresIn: TimeInterval, refreshToken: String, token: String, refreshTokenExpiresIn: Double, refreshCount: Int) {
//            
//            // Store OAuth token and associated data
//            self.refreshTokenExpiresAt = NSDate(timeInterval: refreshTokenExpiresIn, since: NSDate(timeIntervalSince1970: issuedAt) as Date)
//            self.tokenExpiresAt = NSDate(timeInterval: tokenExpiresIn, since: NSDate(timeIntervalSince1970: issuedAt) as Date)
//            self.token = token
//            self.refreshToken = refreshToken
//            
//            // Persist the OAuth token and associated data to NSUserDefaults
//            UserDefaults.standard.set(self.refreshTokenExpiresAt, forKey: "refreshTokenExpiresAt")
//            UserDefaults.standard.set(self.tokenExpiresAt, forKey: "tokenExpiresAt")
//            UserDefaults.standard.set(self.token, forKey: "token")
//            UserDefaults.standard.set(self.refreshToken, forKey: "refreshToken")
//            UserDefaults.standard.synchronize()
//        }
//        
//        init() {
//            // Retrieve OAuth info from NSUserDefaults if available
//            if let refreshTokenExpiresAt = UserDefaults.standard.value(forKey: "refreshTokenExpiresAt") as? NSDate {
//                self.refreshTokenExpiresAt = refreshTokenExpiresAt
//            }
//            if let tokenExpiresAt = UserDefaults.standard.value(forKey: "tokenExpiresAt") as? NSDate {
//                self.tokenExpiresAt = tokenExpiresAt
//            }
//            if let token = UserDefaults.standard.value(forKey: "token") as? String, {
//                self.token = token
//            }
//            if let refreshToken = UserDefaults.standard.value(forKey: "refreshToken") as? String {
//                self.refreshToken = refreshToken
//            }
//        }
//        
//        
//        // MARK: Sign Out
//        
//        func signOut() -> () {
//            
//            // Clear OAuth Info from NSUserDefaults
//            UserDefaults.standard.removeObject(forKey: "refreshTokenExpiresAt")
//            UserDefaults.standard.removeObject(forKey: "tokenExpiresAt")
//            UserDefaults.standard.removeObject(forKey: "token")
//            UserDefaults.standard.removeObject(forKey: "refreshToken")
//        }
//    }
//    
//    
//    // MARK: Singleton Support
//    
//    class var sharedInstance : LoginService {
//        struct Singleton {
//            static let instance = LoginService()
//        }
//        
//        // Check whether we already have an OAuthInfo instance
//        // attached, if so don't initialiaze another one
//        if Singleton.instance.tokenInfo == nil {
//            // Initialize new OAuthInfo object
//            Singleton.instance.tokenInfo = OAuthInfo()
//        }
//        
//        // Return singleton instance
//        return Singleton.instance
//    }
//    
//    
//    // MARK: Initializers
//    
//    override init() {
//        let sessionConfig = URLSessionConfiguration.default
//        
//        super.init()
//        
//        session = URLSession(configuration: sessionConfig)
//        
//        // Ensure we only have one instance of this class and that it is the Singleton instance
//        dispatch_after(
//            DispatchTime.now(
//                dispatch_time_t(DispatchTime.now()),
//                Int64(0.1 * Double(NSEC_PER_SEC))
//        ), DispatchQueue.main) {
//            assert(self === LoginService.sharedInstance, "Only one instance of LoginManager allowed!")
//        }
//    }
//    
//    
//    // MARK: Login Utilities
//    
//    public func loginWithCompletionHandler(username: String, password: String, completionHandler: ((_ error: String?) -> Void)!) -> () {
//        
//        // Try and get an OAuth token
//        exchangeTokenForUserAccessTokenWithCompletionHandler(username: username, password: password) { (oauthInfo, error) -> () in
//            if (error == nil) {
//                
//                // Everything worked and OAuthInfo was returned
//                self.tokenInfo = oauthInfo!
//                completionHandler(error: nil)
//            } else {
//                
//                // Something went wrong
//                self.tokenInfo = nil
//                completionHandler(error: error)
//            }
//        }
//    }
//    
//    public func signOut() {
//        
//        // Clear the OAuth Info
//        self.tokenInfo.signOut()
//        self.tokenInfo = nil
//    }
//    
//    public func isLoggedIn() -> Bool {
//        var loggedIn:Bool = false
//        if let info = self.tokenInfo {
//            if let tokenExpiresAt = info.tokenExpiresAt {
//                
//                // Check to see OAuth token is still valid
//                if fabs(tokenExpiresAt.timeIntervalSinceNow) > 60 {
//                    loggedIn = true
//                }
//            }
//        }
//        
//        return loggedIn
//    }
//    
//    
//    // MARK: Token Utilities
//    
//    public func token() -> String {
//        if isLoggedIn() {
//            return self.tokenInfo.token
//        } else {
//            return ""
//        }
//    }
//    
//    public func refreshToken() -> String {
//        var refreshToken: String = ""
//        
//        if self.tokenInfo != nil {
//            if fabs(self.tokenInfo.refreshTokenExpiresAt.timeIntervalSinceNow) > 60 {
//                refreshToken = self.tokenInfo.refreshToken
//            }
//        }
//        
//        return refreshToken
//    }
//    
//    
//    // MARK: Private Methods
//    
//    private func exchangeTokenForUserAccessTokenWithCompletionHandler(username: String, password: String, completion: @escaping (OAuthInfo?, _ error: String?) -> ()) {
//        
//        let path = "/oauthfake/token/"
//        let url = ConnectionSettings.apiURLWithPathComponents(path)
//        let request = NSMutableURLRequest(URL: url)
//        request.HTTPMethod = "POST"
//        
//        var params =  "client_id=\(ConnectionSettings.clientId)&client_secret=\(ConnectionSettings.clientSecret)&grant_type=password&login=\(username)&password=\(password)"
//        
//        var err: NSError?
//        request.HTTPBody = params.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        
//        
//        let task = session.dataTaskWithRequest(request) {data, response, error -> Void in
//            
//            var err: NSError?
//            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
//            
//            if (err != nil) {
//                
//                // Something went wrong, log the error to the console.
//                println(err!.localizedDescription)
//                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
//                println("Something went wrong: '\(jsonStr)")
//                
//                
//                completion(nil, error: err?.localizedDescription)
//            } else {
//                if let parseJSON = json {
//                    if let token = parseJSON.valueForKey("access_token") as? String {
//                        if var issuedAt = parseJSON.valueForKey("issued_at") as? String {
//                            if var tokenExpiresIn = parseJSON.valueForKey("expires_in") as? String {
//                                if var refreshTokenIssuedAt = parseJSON.valueForKey("refresh_token_issued_at") as? String {
//                                    if let refreshToken = parseJSON.valueForKey("refresh_token") as? String {
//                                        if var refreshTokenExpiresIn = parseJSON.valueForKey("refresh_token_expires_in") as? String {
//                                            if let refreshCount = parseJSON.valueForKey("refresh_count") as? String {
//                                                
//                                                let epochIssuedAt:Double = (issuedAt as NSString).doubleValue / 1000.0
//                                                let epochRefreshTokenIssuedAt:Double = (refreshTokenIssuedAt as NSString).doubleValue / 1000.0
//                                                
//                                                let oauthInfo = OAuthInfo(issuedAt: epochIssuedAt, refreshTokenIssuedAt: epochRefreshTokenIssuedAt, tokenExpiresIn: (tokenExpiresIn as NSString).doubleValue, refreshToken: refreshToken, token: token, refreshTokenExpiresIn: (refreshTokenExpiresIn as NSString).doubleValue, refreshCount: (refreshCount as NSString).integerValue)
//                                                
//                                                completion(oauthInfo, error: err?.localizedDescription)
//                                            }
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                    if let error = parseJSON["error"] as? String {
//                        completion(nil, error: error)
//                    }
//                }
//            }
//        }
//        task.resume()
//}
//  
