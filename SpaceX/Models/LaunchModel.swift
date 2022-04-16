//

import Foundation

struct LaunchModel: Decodable {
    let fairings: Fairings?
    let links: Links
    let static_fire_date_utc: String?
    let static_fire_date_unix: Int?
    let tdb: Bool?
    let net: Bool?
    let window: Int?
    let rocket: String?
    let success: Bool?
    let failures: [Failure]
    let details: String?
    let crew: [String]
    let ships: [String]
    let capsules: [String]
    let payloads: [String]
    let launchpad: String?
    let auto_update: Bool
    let flight_number: Int
    let name: String
    let date_utc: String
    let date_unix: Int
    let upcoming: Bool
    let cores: [Core]
    let id: String

    struct Core: Decodable {
        let core: String?
        let flight: Int?
        let gridfins: Bool?
        let legs: Bool?
        let reused: Bool?
        let landing_attempt: Bool?
        let landing_success: Bool?
        let landing_type: String?
        let landpad: String?
    }

    struct Failure: Decodable {
        let time: Int
        let altitude: Double?
        let reason: String
    }

    struct Fairings: Decodable {
        let reused: Bool?
        let recovery_attempt: Bool?
        let recovered: Bool?
        let ships: [String]
    }

    struct Links: Decodable {
        let patch: Patch
        let reddit: Reddit
        let flickr: Flickr
        let presskit: String?
        let webcast: String?
        let youtube_id: String?
        let article: String?
        let wikipedia: String?

        struct Patch: Decodable {
            let small: String?
            let large: String?
        }

        struct Reddit: Decodable {
            let campaign: String?
            let launch: String?
            let media: String?
            let recovery: String?
        }

        struct Flickr: Decodable {
            let small: [String]
            let original: [String]
        }
    }
}
