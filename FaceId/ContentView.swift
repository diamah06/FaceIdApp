//
//  ContentView.swift
//  FaceId
//
//  Created by Mahdia Amriou on 20/11/2023.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @State private var isUnlocked = false

    var body: some View {
        VStack {
            if isUnlocked {
                Text("Application Unlocked")
                    .font(.title)
                    .foregroundColor(.green)
                Image(systemName: "lock.open")
                //Image("chest-locked")
                    .font(.system(size: 100))
                    .foregroundColor(.green)
                    .padding()
                Button("Lock") {
                    isUnlocked = false
                }
                .foregroundColor(.red)
            } else {
                Text("Application Locked")
                    .font(.title)
                    .foregroundColor(.red)
                Image(systemName: "lock.circle")
                //Image("chest-locked")
                    .font(.system(size: 100))
                    .foregroundColor(.red)
                    .padding()
                Button("Open") {
                    authenticate()
                }
                .foregroundColor(.green)
            }
        }
    }
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    // authenticated successfully
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
    
}

#Preview {
    ContentView()
}
