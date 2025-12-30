//
//  HomeView.swift
//  UTCTimeLookeriOS
//
//  Created by Lei Levi on 4/12/2025.
//

import SwiftUI
import UTCTimeCore

struct HomeView: View {
    @State private var model = TimeInputModel()

    var body: some View {
        HomeScreen(model: model)
    }
}

private struct HomeScreen: View {
    @Bindable var model: TimeInputModel

    var body: some View {
        NavigationStack {
            List {
                Section("Input") {
                    TextField("UTC time (e.g. 2025-07-28T14:30:00Z)", text: $model.utcInput)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .font(.system(.body, design: .monospaced))
                    Button("Use Current UTC") {
                        model.refreshWithCurrentTime()
                    }
                }

                if !model.errorMessage.isEmpty {
                    Section {
                        Text(model.errorMessage)
                            .font(.footnote)
                            .foregroundStyle(.red)
                    }
                }

                Section("Time Zones") {
                    ForEach(model.predefinedTimeZones, id: \.identifier) { timeZone in
                        HStack(alignment: .firstTextBaseline) {
                            Text(timeZone.flag)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(timeZone.name)
                                    .font(.headline)
                                Text(timeZone.identifier)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            VStack(alignment: .trailing, spacing: 4) {
                                Text(model.getTimeInTimeZone(timeZone))
                                    .font(.system(.body, design: .monospaced))
                                Text(model.getTimeZoneOffset(timeZone.timeZone))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("UTC Time")
        }
    }
}

#Preview {
    HomeView()
}
