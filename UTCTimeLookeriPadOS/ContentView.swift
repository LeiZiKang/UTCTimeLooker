//
//  ContentView.swift
//  UTCTimeLookeriPadOS
//
//  Created by Lei Levi on 3/12/2025.
//

import SwiftUI
import UTCTimeCore

struct ContentView: View {
    @State private var model = PadTimeModel()

    var body: some View {
        HomeView(model: model)
    }
}

private struct HomeView: View {
    @Bindable var model: PadTimeModel

    var body: some View {
        NavigationSplitView {
            SidebarView(model: model)
        } detail: {
            TimeZoneGrid(model: model)
        }
        .navigationSplitViewStyle(.balanced)
    }
}

private struct SidebarView: View {
    @Bindable var model: PadTimeModel

    var body: some View {
        List {
            Section("Input") {
                TextField("UTC time (e.g. 2025-07-28T14:30:00Z)", text: $model.utcInput)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .font(.system(.body, design: .monospaced))
                HStack {
                    Button("Use Current UTC") {
                        model.refreshWithCurrentTime()
                    }
                    Button("Clear") {
                        model.utcInput = ""
                    }
                }
                Text("Formats: ISO 8601, simplified, timezone offset, or Unix timestamp.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Section("Device") {
                LabeledContent("Time Zone", value: model.currentTimeZoneName)
                LabeledContent("Offset", value: model.currentOffsetString())
            }

            if !model.errorMessage.isEmpty {
                Section("Error") {
                    Text(model.errorMessage)
                        .font(.footnote)
                        .foregroundStyle(.red)
                }
            }
        }
        .navigationTitle("UTC Input")
    }
}

private struct TimeZoneGrid: View {
    @Bindable var model: PadTimeModel
    private let columns = [
        GridItem(.flexible(minimum: 220), spacing: 16),
        GridItem(.flexible(minimum: 220), spacing: 16),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                CurrentTimeZoneCard(model: model)
                ForEach(model.predefinedTimeZones, id: \.identifier) { timeZone in
                    TimeZoneCard(model: model, timeZone: timeZone)
                }
            }
            .padding(20)
        }
        .navigationTitle("Conversions")
    }
}

private struct CurrentTimeZoneCard: View {
    @Bindable var model: PadTimeModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("Local Time", systemImage: "location.fill")
                .font(.headline)
            Text(model.currentTimeString())
                .font(.system(.title3, design: .monospaced))
            Text(model.currentTimeZoneName)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(model.currentOffsetString())
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

private struct TimeZoneCard: View {
    @Bindable var model: PadTimeModel
    let timeZone: TimeZoneInfo

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Text(timeZone.flag)
                    .font(.title2)
                Text(timeZone.name)
                    .font(.headline)
            }
            Text(model.formattedTime(for: timeZone))
                .font(.system(.title3, design: .monospaced))
            Text(timeZone.identifier)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(model.offsetString(for: timeZone))
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

#Preview {
    ContentView()
}
