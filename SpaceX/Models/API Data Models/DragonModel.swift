//

import Foundation

struct DragonModel: Decodable {
    let heat_shield: HeatShield
    let launch_payload_mass: Mass
    let launch_payload_vol: Volume
    let return_payload_mass: Mass
    let return_payload_vol: Volume
    let pressurized_capsule: PressurizedCapsule
    let trunk: Trunk
    let height_w_trunk: Dimensions
    let diameter: Dimensions
    let first_flight: String?
    let flickr_images: [String]
    let name: String
    let type: String
    let active: Bool
    let crew_capacity: Int
    let sidewall_angle_deg: Double
    let orbit_duration_yr: Double
    let dry_mass_kg: Double
    let dry_mass_lb: Double
    let thrusters: [Thruster]
    let wikipedia: String
    let description: String
    let id: String

    struct HeatShield: Decodable {
        let material: String
        let size_meters: Double
        let temp_degrees: Double
        let dev_partner: String
    }

    struct Mass: Decodable {
        let kg: Double
        let lb: Double
    }

    struct Volume: Decodable {
        let cubic_meters: Double
        let cubic_feet: Double
    }

    struct Dimensions: Decodable {
        let meters: Double
        let feet: Double
    }

    struct PressurizedCapsule: Decodable {
        let payload_volume: Volume
    }

    struct Trunk: Decodable {
        let trunk_volume: Volume
        let cargo: Cargo

        struct Cargo: Decodable {
            let solar_array: Int
            let unpressurized_cargo: Bool
        }
    }

    struct Thruster: Decodable {
        let type: String
        let amount: Int
        let pods: Int
        let fuel_1: String
        let fuel_2: String
        let isp: Double
        let thrust: Thrust

        struct Thrust: Decodable {
            let kN: Double
            let lbf: Double
        }
    }
}
