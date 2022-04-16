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
    func fetch<T: Decodable>(for route: Routes, with id: String? = nil, completion: @escaping ([T]) -> Void) {
        // build urlString
        let urlString = "\(baseURLString)\(route.rawValue)/\(id ?? "")"
        // urlString to URL
        guard let url = URL(string: urlString) else { return }

        // request and decode
        // if its Company, or Roadster, or has an id, request only one and return it in a one item array
        if T.self == CompanyModel.self || T.self == RoadsterModel.self || id != nil {
            url.requestDataAndDecode { (decodedData: T) in
                DispatchQueue.main.async {
                    completion([decodedData])
                }
            }
        } else {
            url.requestDataAndDecode { (decodedData: [T]) in
                DispatchQueue.main.async {
                    completion(decodedData)
                }
            }
        }
    }

    // Get launches
    func fetchLaunches(for param: LaunchTime = .all, completion: @escaping ([LaunchModel]) -> Void) {
        // build urlString
        let urlString = "\(baseURLString)\(Routes.launches)/\(param.rawValue)"
        // urlString to URL
        guard let url = URL(string: urlString) else {return}

        // request
        switch param {
        case .latest, .next:
            url.requestDataAndDecode { (decodedData: LaunchModel) in
                DispatchQueue.main.async {
                    completion([decodedData])
                }
            }
        case .past, .upcoming, .all:
            url.requestDataAndDecode { (decodedData: [LaunchModel]) in
                DispatchQueue.main.async {
                    completion(decodedData)
                }
            }
        }
    }

    func fetchLaunches(with id: String, completion: @escaping (LaunchModel) -> Void) {
        // build urlString
        let urlString = "\(baseURLString)\(Routes.launches)/\(id)"
        // urlString to URL
        guard let url = URL(string: urlString) else {return}

        // request
        url.requestDataAndDecode { (decodedData: LaunchModel) in
            DispatchQueue.main.async {
                completion(decodedData)
            }
        }
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
