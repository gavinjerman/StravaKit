//
//  File.swift
//  
//
//  Created by Gustavo Ferrufino on 2024-11-28.
//

import Foundation

/// Stats are aggregated data for an athlete.
public struct AthleteStats: Codable {
    /// Totals represent aggregated metrics for a specific activity type.
    public final class Totals: Codable {
        /// Total count of activities.
        public let count: Int?
        /// Total distance in meters.
        public let distance: Double?
        /// Total moving time in seconds.
        public let movingTime: TimeInterval?
        /// Total elapsed time in seconds.
        public let elapsedTime: TimeInterval?
        /// Total elevation gain in meters.
        public let elevationGain: Double?
        /// Total number of achievements.
        public let achievementCount: Int?
    }

    /// Biggest ride distance recorded by the athlete (in meters).
    public let biggestRideDistance: Double?
    /// Biggest elevation gain recorded in a single climb (in meters).
    public let biggestClimbElevationGain: Double?
    /// Totals for recent rides.
    public let recentRideTotals: Totals?
    /// Totals for recent runs.
    public let recentRunTotals: Totals?
    /// Totals for recent swims.
    public let recentSwimTotals: Totals?
    /// Year-to-date totals for rides.
    public let ytdRideTotals: Totals?
    /// Year-to-date totals for runs.
    public let ytdRunTotals: Totals?
    /// Year-to-date totals for swims.
    public let ytdSwimTotals: Totals?
    /// Lifetime totals for rides.
    public let allRideTotals: Totals?
    /// Lifetime totals for runs.
    public let allRunTotals: Totals?
    /// Lifetime totals for swims.
    public let allSwimTotals: Totals?

    /// Coding keys to map JSON keys to properties.
    private enum CodingKeys: String, CodingKey {
        case biggestRideDistance = "biggest_ride_distance"
        case biggestClimbElevationGain = "biggest_climb_elevation_gain"
        case recentRideTotals = "recent_ride_totals"
        case recentRunTotals = "recent_run_totals"
        case recentSwimTotals = "recent_swim_totals"
        case ytdRideTotals = "ytd_ride_totals"
        case ytdRunTotals = "ytd_run_totals"
        case ytdSwimTotals = "ytd_swim_totals"
        case allRideTotals = "all_ride_totals"
        case allRunTotals = "all_run_totals"
        case allSwimTotals = "all_swim_totals"
    }
}
