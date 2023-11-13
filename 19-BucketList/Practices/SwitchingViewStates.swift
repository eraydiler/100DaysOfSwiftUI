//
//  SwitchingViewStates.swift
//  BucketList
//
//  Created by Eray Diler on 6.11.2023.
//

import SwiftUI

fileprivate enum LoadingState {
    case loading, success, failed
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}
struct SuccessView: View {
    var body: some View {
        Text("Success!.")
    }
}
struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}
struct SwitchingViewStates: View {
    private var loadingState = LoadingState.loading

    var body: some View {
        if loadingState == .loading {
            LoadingView()
        } else if loadingState == .success {
            SuccessView()
        } else if loadingState == .failed {
            FailedView()
        }
    }
}

#Preview {
    SwitchingViewStates()
}
