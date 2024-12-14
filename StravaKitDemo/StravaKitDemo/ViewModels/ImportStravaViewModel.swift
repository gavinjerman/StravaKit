//
//  ImportStravaViewModel.swift
//  StravaKitDemo
//
//  Created by Gustavo Ferrufino on 2024-12-14.
//

import Foundation
import StravaKit

@MainActor
final class ImportStravaViewModel: ObservableObject {
    @Published var activities: [Activity] = []
    @Published var selectedActivities: Set<Activity> = []
    @Published var loading = false
    
    private let stravaService: StravaService
    
    init(stravaService: StravaService) {
        self.stravaService = stravaService
    }
    
    func loadItems() async {
        await MainActor.run { loading = true }
        defer { Task { await MainActor.run { loading = false } } }

        do {
            let fetchedActivities = try await stravaService.fetchActivities()
            await MainActor.run { activities = fetchedActivities }
        } catch {
            print("DEBUG:: Error loading items: \(error)")
        }
    }
    
    /// Toggle selection for an activity
    func toggleSelection(for activity: Activity) {
        if selectedActivities.contains(activity) {
            selectedActivities.remove(activity)
        } else {
            selectedActivities.insert(activity)
        }
    }

    /// Check if an activity is selected
    func isSelected(item: Activity) -> Bool {
        selectedActivities.contains(item)
    }
    
    func logout() async {
        await stravaService.logout()
        await MainActor.run {
            // Ensure any state updates are on the main thread
            selectedActivities.removeAll()
        }
    }
}
