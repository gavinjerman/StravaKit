//
//  ImportRowView.swift
//  StravaKitDemo
//
//  Created by Gustavo Ferrufino on 2024-12-14.
//

import SwiftUI
import StravaKit

struct ImportStravaRowView<T: StravaItem>: View {
    let item: T
    let isSelected: Bool
    let onToggle: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            // Map
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 120, height: 150)
                .overlay(
                    Text("No Map")
                        .foregroundColor(.gray)
                )

            VStack(alignment: .leading, spacing: 6) {
                Text(item.name ?? "No name")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("\(Image(systemName: item.typeIconName)) \(item.formattedDistance) | \(item.formattedElevation)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(10)

            Spacer()

            // Toggle Checkbox
            Button(action: onToggle) {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isSelected ? .green : .gray)
            }
            .padding(.trailing, 10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.secondarySystemBackground))
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
        .clipped()
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}

