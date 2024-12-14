//
//  ContentViewModel.swift
//  StravaKitDemo
//
//  Created by Gustavo Ferrufino on 2024-12-14.
//

import Foundation
import StravaKit

final class ContentViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var shouldNavigateToStravaImport = false

    private let stravaService: StravaService
    
    init(stravaService: StravaService) {
        self.stravaService = stravaService
        Task {
            await checkAuthenticationState()
        }
    }
    
    public func handleStravaTap() async {
        await checkAuthenticationState()
        if isAuthenticated {
            await MainActor.run { shouldNavigateToStravaImport = true }
        } else {
            await MainActor.run { isLoading = true }
            await stravaService.login()
            await checkAuthenticationState()
            await MainActor.run { isLoading = false }
        }
    }
    
    public func handleAuthResponse(url: URL) async throws {
        await MainActor.run { isLoading = true }
        _ = try await stravaService.handleAuthResponse(url: url)
        await checkAuthenticationState()
        await MainActor.run { isLoading = false }
    }
    
    public func checkAuthenticationState() async {
        let authenticated = await stravaService.isAuthenticated()
        await MainActor.run { isAuthenticated = authenticated }
    }
}
