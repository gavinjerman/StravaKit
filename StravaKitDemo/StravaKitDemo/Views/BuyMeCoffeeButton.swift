//
//  BuyMeCoffeeButton.swift
//  StravaKitDemo
//
//  Created by Gustavo Ferrufino on 2024-12-14.
//

import SwiftUI

struct BuyMeACoffeeButton: View {
    private let url = URL(string: "https://buymeacoffee.com/ferrufino")!

    var body: some View {
        Button(action: {
            openURL(url)
        }) {
            Text("Done with ❤️ by Gustavo Ferrufino")
                .font(.footnote)
                .foregroundColor(.blue)
                .underline()
        }
    }

    private func openURL(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
