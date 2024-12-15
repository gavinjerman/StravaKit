//
//  Comment.swift
//  
//
//  Created by Gustavo Ferrufino on 2024-11-28.
//

import Foundation

/// Represents a comment on an activity. Comments can be viewed by any user, but only internal applications are allowed to create or delete them.
/// To enable comment posting for your application, email developers@strava.com.
public struct Comment: Codable {
    /// Comment ID.
    public let id: Int?
    /// The resource state indicating the level of detail in the comment representation.
    public let resourceState: ResourceState?
    /// ID of the activity associated with this comment.
    public let activityId: Int?
    /// The text content of the comment.
    public let text: String?
    /// The athlete who posted the comment.
    public let athlete: Athlete?
    /// The date and time when the comment was created.
    public let createdAt: Date?

    /// Coding keys to map properties to JSON keys.
    private enum CodingKeys: String, CodingKey {
        case id
        case resourceState = "resource_state"
        case activityId = "activity_id"
        case text
        case athlete
        case createdAt = "created_at"
    }
}
