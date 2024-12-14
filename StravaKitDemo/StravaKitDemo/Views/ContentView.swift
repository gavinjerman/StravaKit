//
//  ContentView.swift
//  StravaKitDemo
//
//  Created by Gustavo Ferrufino on 2024-12-14.
//

import SwiftUI

public struct ContentView: View {
    @StateObject private var viewModel: ContentViewModel
    @State private var task: Task<Void, Never>?
    @State private var taskHandleOpenURL: Task<Void, Never>?
    @State private var taskAuthentication: Task<Void, Never>?

    private var importStravaView: ImportStravaView
    
    init(container: DIContainer) {
        let viewModel = ContentViewModel(stravaService: container.stravaService)
        _viewModel = StateObject(wrappedValue: viewModel)
        
        let stravaImportViewModel = ImportStravaViewModel(stravaService: container.stravaService)
        importStravaView = ImportStravaView(viewModel: stravaImportViewModel)
    }

    public var body: some View {
        NavigationStack {
            VStack {
                Text("StravaKit Demo")
                    .font(.headline)
                    .padding(.top, 50)
                Spacer()
                ImportCard(
                    title: viewModel.isAuthenticated ? "Import Strava" : "LogIn to Strava",
                    isLoading: viewModel.isLoading,
                    isEnabled: true,
                    color: viewModel.isAuthenticated ? .orange : .blue,
                    action: {
                        task = Task {
                            await viewModel.handleStravaTap()
                        }
                    })
                Spacer()
                BuyMeACoffeeButton()
                    .padding(.bottom, 20)
            }
            .navigationDestination(isPresented: $viewModel.shouldNavigateToStravaImport) {
                importStravaView
            }
        }
        .onOpenURL { url in
            handleOpenURL(url: url)
        }
        .onAppear(){
            taskAuthentication = Task {
                await viewModel.checkAuthenticationState()
            }
        }
        .onDisappear() {
            task?.cancel()
            taskHandleOpenURL?.cancel()
            taskAuthentication?.cancel()
        }
        .padding()
    }
    
    private func handleOpenURL(url: URL) {
        taskHandleOpenURL = Task {
            do {
                try await viewModel.handleAuthResponse(url: url)
            } catch {
                print("Error handling redirect: \(error.localizedDescription)")
            }
        }
    }
}
