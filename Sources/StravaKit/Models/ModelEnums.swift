//
//  ModelEnums.swift
//
//
//  Created by Gustavo Ferrufino on 2024-11-28.
//

import Foundation

/// Athlete's gender.
public enum Sex: String, Codable {
    /// Male gender.
    case male = "M"
    /// Female gender.
    case female = "F"
}

/// The following status of the athlete.
public enum FollowingStatus: String, Codable {
    /// Follow request accepted.
    case accepted
    /// Athlete is blocked.
    case blocked
    /// Follow request is pending.
    case pending
}

/// Membership status for a club.
public enum MembershipStatus: String, Codable {
    /// Member of the club.
    case member
    /// Pending membership approval.
    case pending
}

/// Measurement units used in activities.
public enum Units: String, Codable {
    /// Measurement in feet.
    case feet
    /// Measurement in meters.
    case meters
}

/// Resource state, describing the level of detail for a resource.
public enum ResourceState: Int, Codable {
    /// Minimal metadata about the resource.
    case meta = 1
    /// Summary-level details about the resource.
    case summary = 2
    /// Full detailed representation of the resource.
    case detailed = 3
}

/// Type of workout performed.
public enum WorkoutType: Int, Codable {
    /// A regular run.
    case run = 0
    /// A race run.
    case raceRun = 1
    /// A long-distance run.
    case longRun = 3
    /// A structured workout run.
    case workoutRun = 4
    /// A regular cycling ride.
    case ride = 10
    /// A race cycling ride.
    case raceRide = 11
    /// A structured workout cycling ride.
    case workoutRide = 12
}

/// Type of activity performed.
public enum ActivityType: String, Codable {
    /// Alpine skiing activity.
    case alpineSki = "AlpineSki"
    /// Backcountry skiing activity.
    case backcountrySki = "BackcountrySki"
    /// Canoeing activity.
    case canoeing = "Canoeing"
    /// Crossfit workout activity.
    case crossfit = "Crossfit"
    /// Electric bike ride activity.
    case eBikeRide = "EBikeRide"
    /// Elliptical workout activity.
    case elliptical = "Elliptical"
    /// Golfing activity.
    case golf = "Golf"
    /// Handcycling activity.
    case handcycle = "Handcycle"
    /// Hiking activity.
    case hike = "Hike"
    /// Ice skating activity.
    case iceSkate = "IceSkate"
    /// Inline skating activity.
    case inlineSkate = "InlineSkate"
    /// Kayaking activity.
    case kayaking = "Kayaking"
    /// Kitesurfing activity.
    case kitesurf = "Kitesurf"
    /// Nordic skiing activity.
    case nordicSki = "NordicSki"
    /// Regular cycling ride activity.
    case ride = "Ride"
    /// Rock climbing activity.
    case rockClimbing = "RockClimbing"
    /// Roller skiing activity.
    case rollerSki = "RollerSki"
    /// Rowing activity.
    case rowing = "Rowing"
    /// Running activity.
    case run = "Run"
    /// Sailing activity.
    case sail = "Sail"
    /// Skateboarding activity.
    case skateboard = "Skateboard"
    /// Snowboarding activity.
    case snowboard = "Snowboard"
    /// Snowshoeing activity.
    case snowshoe = "Snowshoe"
    /// Soccer activity.
    case soccer = "Soccer"
    /// Stair stepping activity.
    case stairStepper = "StairStepper"
    /// Stand-up paddleboarding activity.
    case standUpPaddling = "StandUpPaddling"
    /// Surfing activity.
    case surfing = "Surfing"
    /// Swimming activity.
    case swim = "Swim"
    /// Velomobile riding activity.
    case velomobile = "Velomobile"
    /// Virtual cycling ride activity.
    case virtualRide = "VirtualRide"
    /// Virtual running activity.
    case virtualRun = "VirtualRun"
    /// Walking activity.
    case walk = "Walk"
    /// Weight training activity.
    case weightTraining = "WeightTraining"
    /// Wheelchair activity.
    case wheelchair = "Wheelchair"
    /// Windsurfing activity.
    case windsurf = "Windsurf"
    /// General workout activity.
    case workout = "Workout"
    /// Yoga activity.
    case yoga = "Yoga"
}

/// Type of sport.
public enum SportType: String, Codable {
    /// Cycling sport.
    case cycling
    /// Running sport.
    case running
    /// Triathlon sport.
    case triathlon
    /// Other unspecified sport.
    case other
}

/// Type of cycling club.
public enum ClubType: String, Codable {
    /// A casual club.
    case casualClub = "casual_club"
    /// A racing team.
    case racingTeam = "racing_team"
    /// A bike shop club.
    case shop
    /// A company-sponsored club.
    case company
    /// Other types of clubs.
    case other
}

/// Type of bicycle frame used.
public enum FrameType: Int, Codable {
    /// Mountain bike frame.
    case mtb = 1
    /// Cyclocross bike frame.
    case cross = 2
    /// Road bike frame.
    case road = 3
    /// Time trial bike frame.
    case timeTrial = 4
}

/// Resolution quality for images or streams.
public enum ResolutionType: String, Codable {
    /// Low resolution.
    case low
    /// Medium resolution.
    case medium
    /// High resolution.
    case high
}

/// Type of data in activity streams.
public enum StreamType: String, Codable {
    /// Time data in integer seconds.
    case time
    /// Latitude and longitude coordinates as floats.
    case latLng = "latlng"
    /// Distance data in float meters.
    case distance
    /// Altitude data in float meters.
    case altitude
    /// Smoothed velocity data in float meters per second.
    case velocitySmooth = "velocity_smooth"
    /// Heart rate data in integer BPM.
    case heartRate = "heartrate"
    /// Cadence data in integer RPM.
    case cadence
    /// Power output data in integer watts.
    case watts
    /// Temperature data in integer degrees Celsius.
    case temp
    /// Moving state as a boolean.
    case moving
    /// Smoothed grade percentage data in float.
    case gradeSmooth = "grade_smooth"

    /// Description of the units associated with each stream type.
    var unit: String {
        switch self {
        case .time:
            return "integer seconds"
        case .latLng:
            return "floats [latitude, longitude]"
        case .distance:
            return "float meters"
        case .altitude:
            return "float meters"
        case .velocitySmooth:
            return "float meters per second"
        case .heartRate:
            return "integer BPM"
        case .cadence:
            return "integer RPM"
        case .watts:
            return "integer watts"
        case .temp:
            return "integer degrees Celsius"
        case .moving:
            return "boolean"
        case .gradeSmooth:
            return "float percent"
        }
    }
}

/// Skill level for cycling or athletic performance.
public enum SkillLevel: Int, Codable {
    /// Casual level.
    case casual = 1
    /// Tempo level.
    case tempo = 2
    /// Hammerfest level.
    case hammerfest = 4
}

/// Terrain type for a route.
public enum Terrain: Int, Codable {
    /// Mostly flat terrain.
    case mostlyFlat
    /// Rolling hills terrain.
    case rollingHills
    /// Terrain with steep climbs.
    case killerClimbs
}

/// Source of a photo.
public enum PhotoSource: Int, Codable {
    /// Photo uploaded via Strava.
    case strava = 1
    /// Photo uploaded via Instagram.
    case instagram = 2
}

/// Achievement type for an activity.
public enum AchievementType: String, Codable {
    /// Overall achievement.
    case overall
    /// Personal record achievement.
    case pr
    /// Yearly overall achievement.
    case yearOverall = "year_overall"
}

/// Type of route.
public enum RouteType: Int, Codable {
    /// Cycling route.
    case ride = 1
    /// Running route.
    case run = 2
    /// Walking route.
    case walk = 3
    /// Hiking route.
    case hike = 4
}

/// Subtype of a route.
public enum RouteSubType: Int, Codable {
    /// Road route.
    case road = 1
    /// Mountain bike route.
    case mtb = 2
    /// Cyclocross route.
    case cx = 3
    /// Trail route.
    case trail = 4
    /// Mixed terrain route.
    case mixed = 5
}


/// Data type enum for uploaded activities
public enum DataType: String {
    case fit
    case fitGz = "fit.gz"
    case tcx
    case tcxGz = "tcx.gz"
    case gpx
    case gpxGz = "gpx.gz"
}
