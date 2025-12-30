//
//  AccessibilityButton.swift
//  UTCTimeLookerMacOS
//
//  Created by Lei Levi on 30/12/2025.
//

import SwiftUI


/// A Button with help content for accessibility & blind
struct AccessibilityButton<Label: View>: View {
    let helpText: String
    let accessibilityLabel: String?
    let role: ButtonRole?
    let action: () -> Void
    let label: () -> Label

    init(
        helpText: String,
        accessibilityLabel: String? = nil,
        role: ButtonRole? = nil,
        action: @escaping () -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        assert(!helpText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, "AccessibilityButton requires help text.")
        self.helpText = helpText
        self.accessibilityLabel = accessibilityLabel
        self.role = role
        self.action = action
        self.label = label
    }

    var body: some View {
        Button(role: role, action: action, label: label)
            .help(helpText)
            .accessibilityLabel(Text(accessibilityLabel ?? helpText))
    }
}

extension AccessibilityButton where Label == Text {
    init(
        _ titleKey: LocalizedStringKey,
        helpText: String,
        accessibilityLabel: String? = nil,
        role: ButtonRole? = nil,
        action: @escaping () -> Void
    ) {
        self.init(helpText: helpText, accessibilityLabel: accessibilityLabel, role: role, action: action) {
            Text(titleKey)
        }
    }

    init(
        _ title: String,
        helpText: String,
        accessibilityLabel: String? = nil,
        role: ButtonRole? = nil,
        action: @escaping () -> Void
    ) {
        self.init(helpText: helpText, accessibilityLabel: accessibilityLabel, role: role, action: action) {
            Text(title)
        }
    }
}

extension AccessibilityButton where Label == Image {
    init(
        helpText: String,
        systemImage: String,
        accessibilityLabel: String? = nil,
        role: ButtonRole? = nil,
        action: @escaping () -> Void
    ) {
        self.init(helpText: helpText, accessibilityLabel: accessibilityLabel, role: role, action: action) {
            Image(systemName: systemImage)
        }
    }

    init(
        helpText: String,
        image: Image,
        accessibilityLabel: String? = nil,
        role: ButtonRole? = nil,
        action: @escaping () -> Void
    ) {
        self.init(helpText: helpText, accessibilityLabel: accessibilityLabel, role: role, action: action) {
            image
        }
    }
}

extension AccessibilityButton where Label == SwiftUI.Label<Text, Image> {
    init(
        _ titleKey: LocalizedStringKey,
        systemImage: String,
        helpText: String,
        accessibilityLabel: String? = nil,
        role: ButtonRole? = nil,
        action: @escaping () -> Void
    ) {
        self.init(helpText: helpText, accessibilityLabel: accessibilityLabel, role: role, action: action) {
            SwiftUI.Label(titleKey, systemImage: systemImage)
        }
    }

    init(
        _ title: String,
        systemImage: String,
        helpText: String,
        accessibilityLabel: String? = nil,
        role: ButtonRole? = nil,
        action: @escaping () -> Void
    ) {
        self.init(helpText: helpText, accessibilityLabel: accessibilityLabel, role: role, action: action) {
            SwiftUI.Label(title, systemImage: systemImage)
        }
    }
}
