//
//  ContentView.swift
//  UTCTimeLooker
//
//  Created by Lei Levi on 28/7/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TimeZoneViewModel()
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            VStack(spacing: 8) {
                Image(systemName: "clock.arrow.2.circlepath")
                    .font(.system(size: 32))
                    .foregroundColor(.blue)
                
                Text("UTC Time Looker")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .padding(.top, 10)
            
            // UTC Input Section
            VStack(alignment: .leading, spacing: 12) {
                Text("UTC Time Input:")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                HStack {
                    TextField("2025-07-28T14:30:00Z", text: $viewModel.utcInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($isInputFocused)
                        .onChange(of: viewModel.utcInput) { _, newValue in
                            viewModel.parseUTCInput(newValue)
                        }
                    
                    Button(action: {
                        viewModel.refreshWithCurrentTime()
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.title3)
                    }
                    .buttonStyle(BorderedButtonStyle())
                    .help("Use current time")
                }
                
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .font(.caption)
                        .foregroundColor(.red)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(.horizontal)
            
            Divider()
            
            // Current Time Zone Section
            if viewModel.isValidInput {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "location")
                            .foregroundColor(.blue)
                        Text("Current Time Zone")
                            .font(.headline)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(viewModel.getCurrentTimeZoneName()) (\(viewModel.getCurrentTimeZoneOffset()))")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text(viewModel.getCurrentTimeZoneTime())
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)
                
                Divider()
                
                // Other Time Zones Section
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "globe")
                            .foregroundColor(.green)
                        Text("Other Time Zones")
                            .font(.headline)
                    }
                    .padding(.horizontal)
                    
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.predefinedTimeZones, id: \.identifier) { timeZoneInfo in
                            TimeZoneRow(
                                timeZoneInfo: timeZoneInfo,
                                time: viewModel.getTimeInTimeZone(timeZoneInfo),
                                offset: viewModel.getTimeZoneOffset(timeZoneInfo.timeZone)
                            )
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            Spacer()
        }
        .frame(minWidth: 400, minHeight: 500)
        .onAppear {
            isInputFocused = true
        }
    }
}

struct TimeZoneRow: View {
    let timeZoneInfo: TimeZoneInfo
    let time: String
    let offset: String
    
    var body: some View {
        HStack {
            Text(timeZoneInfo.flag)
                .font(.title2)
            
            Text(timeZoneInfo.name)
                .font(.body)
                .fontWeight(.medium)
                .frame(width: 80, alignment: .leading)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Text(time)
                    .font(.body)
                    .fontWeight(.medium)
                
                Text("(\(offset))")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color.gray.opacity(0.05))
        .cornerRadius(8)
        .contextMenu {
            Button("Copy Time") {
                NSPasteboard.general.clearContents()
                NSPasteboard.general.setString(time, forType: .string)
            }
            
            Button("Copy with Timezone") {
                NSPasteboard.general.clearContents()
                NSPasteboard.general.setString("\(time) (\(timeZoneInfo.identifier) \(offset))", forType: .string)
            }
        }
    }
}

#Preview {
    ContentView()
}

