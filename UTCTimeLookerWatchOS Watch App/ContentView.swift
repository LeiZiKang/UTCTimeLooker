//
//  ContentView.swift
//  UTCTimeLookerWatchOS Watch App
//
//  Created by Lei Levi on 3/12/2025.
//

import SwiftUI
import UTCTimeCore

struct ContentView: View {
    @State private var model = WatchTimeModel()

    var body: some View {
        WatchHomeView(model: model)
    }
}



#Preview {
    ContentView()
}
