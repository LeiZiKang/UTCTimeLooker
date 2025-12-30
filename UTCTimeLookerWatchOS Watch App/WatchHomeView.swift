//
//  WatchHomeView.swift
//  UTCTimeLookerWatchOS Watch App
//
//  Created by Lei Levi on 30/12/2025.
//

import Foundation
import SwiftUI
import UTCTimeCore

struct WatchHomeView: View {
    @Bindable var model: WatchTimeModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("UTC")
                        .font(.headline)
                    Spacer()
                    Button("Now") {
                        model.refreshWithCurrentTime()
                    }
                    .buttonStyle(.bordered)
                }

                TextField("2025-07-28T14:30:00Z", text: $model.utcInput)
                    .font(.system(.caption, design: .monospaced))
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()

                if !model.errorMessage.isEmpty {
                    Text(model.errorMessage)
                        .font(.caption2)
                        .foregroundStyle(.red)
                }

                ForEach(model.predefinedTimeZones, id: \.identifier) { timeZone in
                    HStack(alignment: .top, spacing: 6) {
                        Text(timeZone.flag)
                        VStack(alignment: .leading, spacing: 2) {
                            Text(timeZone.name)
                                .font(.caption)
                            Text(model.formattedTime(for: timeZone))
                                .font(.system(.caption, design: .monospaced))
                            Text(model.offsetString(for: timeZone))
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                        Spacer(minLength: 0)
                    }
                    .padding(.vertical, 2)
                }
            }
            .padding(.horizontal, 8)
        }
    }
}
