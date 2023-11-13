//
//  TouchIDAndFaceID.swift
//  BucketList
//
//  Created by Eray Diler on 8.11.2023.
//

import LocalAuthentication
import SwiftUI

struct TouchIDAndFaceID: View {
    @State private var isUnlocked = false

    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }

    func authenticate() {
        let context = LAContext()
        context.authenticate {
            isUnlocked = true
        } errorHandler: {
            print("Authentication Failed!")
        }
    }
}

#Preview {
    TouchIDAndFaceID()
}


extension LAContext {
    func authenticate(
        reason: String = "We need to unlock your data.",
        successHandler: @escaping  () -> (),
        errorHandler: @escaping () -> ()
    ) {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    // authenticated successfully
                    successHandler()
                } else {
                    // there was a problem
                    errorHandler()
                }
            }
        } else {
            // no biometrics
            errorHandler()
        }
    }
}
