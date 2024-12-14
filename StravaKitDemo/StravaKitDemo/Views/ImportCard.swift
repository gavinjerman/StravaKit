//
//  ImportCardView.swift
//  TrailCast
//
//  Created by Gustavo Ferrufino on 2024-12-10.
//

import SwiftUI

struct ImportCard: View {
    let title: String
    let isLoading: Bool
    let isEnabled: Bool
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(isEnabled ? color : Color.gray.opacity(0.5))
                    .frame(width: 140, height: 100)
                    .shadow(radius: 4)

                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                } else {
                    Text(title)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding()
                }
            }
        }
        .disabled(!isEnabled)
    }
}
