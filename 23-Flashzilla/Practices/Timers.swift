//
//  Timers.swift
//  Flashzilla
//
//  Created by Eray Diler on 19.12.2023.
//

import SwiftUI

struct TimersView: View {

    /**
     That does several things all at once:

     1. It asks the timer to fire every 1 second.
     2. It says the timer should run on the main thread.
     3. It says the timer should run on the common run loop, which is the one you’ll want to use     most of the time. (Run loops let iOS handle running code while the user is actively          doing something, such as scrolling in a list.)
     4. It connects the timer immediately, which means it will start counting time.
     5. It assigns the whole thing to the timer constant so that it stays alive.

        If you need to keep time strictly then leaving off the tolerance parameter will make
        your timer as accurate as possible
     */
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var counter = 0

    var body: some View {
        Text("Hello, World!")
            .onReceive(timer) { time in
                if counter == 5 {
                    timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }

                counter += 1
            }
    }
}

#Preview {
    TimersView()
}
