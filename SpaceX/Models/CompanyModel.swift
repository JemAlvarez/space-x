//

import Foundation

struct CompanyModel: Decodable {
    let headquarters: Headquarters
    let links: Links
    let name: String
    let founder: String
    let founded: Int
    let employees: Int
    let vehicles: Int
    let launch_sites: Int
    let test_sites: Int
    let ceo: String
    let cto: String
    let coo: String
    let cto_propulsion: String
    let valuation: Double
    let summary: String
    let id: String

    struct Headquarters: Decodable {
        let address: String
        let city: String
        let state: String
    }

    struct Links: Decodable {
        let website: String
        let flickr: String
        let twitter: String
        let elon_twitter: String
    }
}
