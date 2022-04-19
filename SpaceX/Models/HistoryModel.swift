//

import Foundation

struct HistoryModel: Decodable {
    let title: String?
    let event_date_utc: String?
    let event_date_unix: Int?
    let details: String?
    let links: Links

    struct Links: Decodable {
        let article: String?
    }
}
