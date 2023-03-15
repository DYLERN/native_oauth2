//
//  AuthManager.swift
//  native_oauth2
//
//  Created by Dylan Pfab on 2023/03/15.
//

import Foundation
import SafariServices

class AuthenticationManager {
    var session: SFAuthenticationSession? = nil
    
    func authenticate(url: URL, redirectUrlScheme: String, callback: @escaping (Result<String?, Error>) -> Void) {
        session = SFAuthenticationSession(url: url, callbackURLScheme: redirectUrlScheme) { redirectUrl, error in
            if let error = error {
                if let error = error as? SFAuthenticationError {
                    if (error.code == SFAuthenticationError.canceledLogin) {
                        callback(Result.ok(nil))
                        return
                    } else {
                        callback(Result.err(error))
                        return
                    }
                } else {
                    callback(Result.err(error))
                    return
                }
            }
            
            callback(Result.ok(redirectUrl?.absoluteString))
            return
        }
        
        session?.start()
    }
}
