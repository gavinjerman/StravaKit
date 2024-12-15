//
//  Photo.swift
//
//
//  Created by Gustavo Ferrufino on 2024-11-28.
//

import Foundation

/// Photos are objects associated with an activity. Photos can either be stored natively on Strava or sourced externally (e.g., Instagram).
public struct Photo: Codable {
    /// Unique identifier for the photo.
    public let id: Int?
    /// Unique ID of the photo (if applicable).
    public let uniqueId: String?
    /// ID of the associated activity.
    public let activityId: Int?
    /// Resource state indicating the level of detail in the photo representation.
    public let resourceState: ResourceState?
    /// URLs of the photo.
    public let urls: [URL]?
    /// Caption associated with the photo.
    public let caption: String?
    /// Source of the photo (e.g., Instagram or Strava).
    public let source: PhotoSource?
    /// Date and time the photo was uploaded.
    public let uploadedAt: Date?
    /// Date and time the photo was created.
    public let createdAt: Date?
    /// Location of the photo, if available.
    public let location: Location?
    /// References associated with the photo.
    public let refs: String?
    /// Universally unique identifier (UUID) of the photo.
    public let uuid: String?
    /// Type of the photo.
    public let type: String?

    /// Coding keys to map properties to JSON keys.
    private enum CodingKeys: String, CodingKey {
        case id
        case uniqueId = "unique_id"
        case activityId = "activity_id"
        case resourceState = "resource_state"
        case urls
        case caption
        case source
        case uploadedAt = "uploaded_at"
        case createdAt = "created_at"
        case location
        case refs
        case uuid
        case type
    }
}
