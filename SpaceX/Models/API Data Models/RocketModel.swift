//

import Foundation

struct RocketModel: Decodable {
    let height: Size
    let diameter: Size
    let mass: Mass
    let first_stage: FirstStage
    let second_stage: SecondStage
    let engines: Engines
    let landing_legs: LandingLegs
    let payload_weights: [PayloadWeight]
    let flickr_images: [String]
    let name: String
    let type: String
    let active: Bool
    let stages: Int
    let boosters: Int
    let cost_per_launch: Double
    let success_rate_pct: Double
    let first_flight: String
    let country: String
    let company: String
    let wikipedia: String
    let description: String
    let id: String

    struct PayloadWeight: Decodable {
        let id: String
        let name: String
        let kg: Double
        let lb: Double
    }

    struct LandingLegs: Decodable {
        let number: Int
        let material: String?
    }

    struct Engines: Decodable {
        let isp: ISP
        let thrust_sea_level: Force
        let thrust_vacuum: Force
        let number: Int
        let type: String
        let version: String
        let layout: String?
        let engine_loss_max: Int?
        let propellant_1: String
        let propellant_2: String
        let thrust_to_weight: Double

        struct ISP: Decodable {
            let sea_level: Double
            let vacuum: Double
        }
    }

    struct FirstStage: Decodable {
        let thrust_sea_level: Force
        let thrust_vacuum: Force
        let reusable: Bool
        let engines: Int
        let fuel_amount_tons: Double
        let burn_time_sec: Int?
    }

    struct SecondStage: Decodable {
        let thrust: Force
        let payloads: Payloads
        let reusable: Bool
        let engines: Int
        let fuel_amount_tons: Double
        let burn_time_sec: Int?

        struct Payloads: Decodable {
            let composite_fairing: CompositeFairing
            let option_1: String
        }

        struct CompositeFairing: Decodable {
            let height: Size
            let diameter: Size
        }
    }

    struct Size: Decodable {
        let meters: Double?
        let feet: Double?
    }

    struct Force: Decodable {
        let kN: Int
        let lbf: Int
    }

    struct Mass: Decodable {
        let kg: Double
        let lb: Double
    }
}
