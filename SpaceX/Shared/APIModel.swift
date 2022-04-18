//

import Foundation
import JsHelper

struct APIModel {
    // MARK: - Properties
    static let shared = APIModel()

    private let baseURLString = "https://api.spacexdata.com/v4/"
}

// MARK: - Request
extension APIModel {
    // Make request
    func fetch<T: Decodable>(for route: Routes, with id: String? = nil) async -> [T] {
        // build urlString
        let urlString = "\(baseURLString)\(route.rawValue)/\(id ?? "")"
        // urlString to URL
        guard let url = URL(string: urlString) else { return [] }

        if T.self == CompanyModel.self || T.self == RoadsterModel.self || id != nil {
            let decodedData: T = await url.requestDataAndDecode()
            return [decodedData]
        } else {
            let decodedData: [T] = await url.requestDataAndDecode()
            return decodedData
        }
    }

    // Get launches
    func fetchLaunches(for param: LaunchTime = .all) async -> [LaunchModel] {
        // build urlString
        let urlString = "\(baseURLString)\(Routes.launches)/\(param.rawValue)"
        // urlString to URL
        guard let url = URL(string: urlString) else { return [] }

        // request
        switch param {
        case .latest, .next:
            let launch: LaunchModel = await url.requestDataAndDecode()
            return [launch]
        case .past, .upcoming, .all:
            let launches: [LaunchModel] = await url.requestDataAndDecode()
            return launches
        }
    }

    func fetchLaunches(with id: String) async -> LaunchModel? {
        // build urlString
        let urlString = "\(baseURLString)\(Routes.launches)/\(id)"
        // urlString to URL
        guard let url = URL(string: urlString) else { return nil }
        // request
        let launch: LaunchModel = await url.requestDataAndDecode()
        return launch
    }
}

// MARK: - Routes and LaunchParam
extension APIModel {
    enum Routes: String {
        case capsules, company, cores, crew, dragons,
             landpads, launches, launchpads, payloads,
             roadster, rockets, ships, starlink, history
    }

    enum LaunchTime: String {
        case latest, next, past, upcoming
        case all = ""
    }
}
