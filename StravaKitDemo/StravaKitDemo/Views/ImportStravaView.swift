//
//  ImportStravaView.swift
//  StravaKitDemo
//
//  Created by Gustavo Ferrufino on 2024-12-14.
//

import SwiftUI
import StravaKit

struct ImportStravaView: View {
    @StateObject private var viewModel: ImportStravaViewModel
    @State private var task: Task<Void, Never>?
    
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: ImportStravaViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.loading {
                    ProgressView()
                        .padding()
                } else {
                    List {
                        ForEach(viewModel.activities) { activity in
                            ImportStravaRowView(item: activity, isSelected: viewModel.isSelected(item: activity)) {
                                viewModel.toggleSelection(for: activity)
                            }
                            .listRowSeparator(.hidden)

                        }
                    }
                    .listStyle(.plain)
                }
                Spacer()
            }
            .background(Color(UIColor.systemBackground))
            .onAppear {
                task = Task {
                    await viewModel.loadItems()
                }
            }
            .onDisappear{
                task?.cancel()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        Task {
                            await viewModel.logout()
                            dismiss()
                        }
                    }) {
                        Text("Logout")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .background(Color(UIColor.systemBackground))
    }
}
