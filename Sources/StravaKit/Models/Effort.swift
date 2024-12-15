//
//  Effort.swift
//
//
//  Created by Gustavo Ferrufino on 2024-11-28.
//

import Foundation

/// A segment effort represents an athlete’s attempt at a segment. It can also be thought of as a portion of a ride that covers a segment.
/// The object is returned in summary or detailed representations, which are currently the same.
public struct Effort: Codable {
    /// Effort ID.
    public let id: Int?
    /// The resource state indicating the level of detail in the effort representation.
    public let resourceState: ResourceState?
    /// Name of the segment effort.
    public let name: String?
    /// Metadata of the associated activity.
    public let activity: MetaActivity?
    /// Athlete who made the effort.
    public let athlete: Athlete?
    /// Total elapsed time for the effort, in seconds.
    public let elapsedTime: Int?
    /// Total moving time for the effort, in seconds.
    public let movingTime: Int?
    /// Start date and time of the effort (UTC).
    public let startDate: Date?
    /// Start date and time of the effort (local time).
    public let startDateLocal: Date?
    /// Total distance covered during the effort, in meters.
    public let distance: Double?
    /// Starting index of the effort in the activity's data stream.
    public let startIndex: Int?
    /// Ending index of the effort in the activity's data stream.
    public let endIndex: Int?
    /// Average cadence during the effort, in revolutions per minute.
    public let averageCadence: Double?
    /// Average power output during the effort, in watts.
    public let averageWatts: Double?
    /// Indicates whether the watts were measured by a device.
    public let deviceWatts: Bool?
    /// Average heart rate during the effort, in beats per minute.
    public let averageHeartRate: Double?
    /// Maximum heart rate during the effort, in beats per minute.
    public let maxHeartRate: Int?
    /// The segment associated with the effort.
    public let segment: Segment?
    /// King of the Mountain (KOM) rank for the effort.
    public let komRank: Int?
    /// Personal record (PR) rank for the effort.
    public let prRank: Int?
    /// Indicates whether the effort is hidden.
    public let hidden: Bool?

    /// Coding keys to map properties to JSON keys.
    private enum CodingKeys: String, CodingKey {
        case id
        case resourceState = "resource_state"
        case name
        case activity
        case athlete
        case elapsedTime = "elapsed_time"
        case movingTime = "moving_time"
        case startDate = "start_date"
        case startDateLocal = "start_date_local"
        case distance
        case startIndex = "start_index"
        case endIndex = "end_index"
        case averageCadence = "average_cadence"
        case averageWatts = "average_watts"
        case deviceWatts = "device_watts"
        case averageHeartRate = "average_heartrate"
        case maxHeartRate = "max_heartrate"
        case segment
        case komRank = "kom_rank"
        case prRank = "pr_rank"
        case hidden
    }
}
