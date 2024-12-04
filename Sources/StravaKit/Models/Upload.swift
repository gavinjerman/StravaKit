//
//  File.swift
//  
//
//  Created by Gustavo Ferrufino on 2024-11-28.
//

import Foundation

/// Represents data for uploading an activity to Strava.
public struct UploadData {
    /// Type of activity (e.g., ride, run).
    public var activityType: ActivityType?
    /// Name of the activity.
    public var name: String?
    /// Description of the activity.
    public var description: String?
    /// Indicates if the activity is private.
    public var `private`: Bool?
    /// Indicates if the activity is a trainer activity.
    public var trainer: Bool?
    /// External ID for the activity (e.g., a unique identifier for the uploaded file).
    public var externalId: String?

    /// Data type of the file (e.g., `.fit`, `.gpx`).
    public var dataType: DataType
    /// File data to be uploaded.
    public var file: Data

    /// Basic initializer for creating an upload with required fields.
    public init(name: String, dataType: DataType, file: Data) {
        self.name = name
        self.dataType = dataType
        self.file = file
    }

    /// Detailed initializer for creating an upload with additional optional fields.
    public init(activityType: ActivityType?, name: String?, description: String?,
                `private`: Bool?, trainer: Bool?, externalId: String?, dataType: DataType, file: Data) {
        self.activityType = activityType
        self.description = description
        self.`private` = `private`
        self.trainer = trainer
        self.externalId = externalId
        self.name = name
        self.dataType = dataType
        self.file = file
    }

    /// Parameters to be sent as part of the multipart form request.
    internal var params: [String: Any] {
        var params: [String: Any] = [:]
        params["data_type"] = dataType.rawValue
        params["name"] = name
        params["description"] = description
        if let `private` = `private` {
            params["private"] = (`private` as NSNumber).stringValue
        }
        if let trainer = trainer {
            params["trainer"] = (trainer as NSNumber).stringValue
        }
        params["external_id"] = externalId
        return params
    }
}

/// Represents the status of an activity upload to Strava.
public struct UploadStatus: Codable {
    /// ID of the upload.
    public let id: Int?
    /// External ID of the uploaded activity.
    public let externalId: String?
    /// Error message, if any, during the upload.
    public let error: String?
    /// Current status of the upload.
    public let status: String?
    /// ID of the associated activity, if processing is successful.
    public let activityId: Int?

    /// Coding keys to map JSON keys to Swift properties.
    private enum CodingKeys: String, CodingKey {
        case id
        case externalId = "external_id"
        case error
        case status
        case activityId = "activity_id"
    }
}
