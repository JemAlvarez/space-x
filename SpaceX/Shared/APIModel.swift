//

import Foundation
import JsHelper

struct APIModel {
    // MARK: - Properties
    static let shared = APIModel()

    private let baseURLString = "https://api.spacexdata.com/v4/"
}

// MARK: - Routes Requests
extension APIModel {
    // MARK: - Fetch capsules
    func fetchCapsules(with id: String? = nil, completion: @escaping ([CapsuleModel]) -> Void) {
        var output: [CapsuleModel] = []

        makeRequest(for: .capsules, with: id) { data in
            guard let data = data else { return }

            do {
                if id != nil {
                    let capsule = try JSONDecoder().decode(CapsuleModel.self, from: data)
                    output = [capsule]
                } else {
                    let capsules = try JSONDecoder().decode([CapsuleModel].self, from: data)
                    output = capsules
                }

                completion(output)
            } catch {
                error.printError(for: "Decoding capsules")
            }
        }
    }
}

// MARK: - Request
extension APIModel {
    private func makeRequest(for route: Routes, with id: String?, completion: @escaping (Data?) -> Void) {
        let urlString = "\(baseURLString)\(route.rawValue)/\(id ?? "")"

        guard let url = URL(string: urlString) else { return }

        url.requestData { data in
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
}

// MARK: - Routes
extension APIModel {
    enum Routes: String {
        case capsules, company, cores, crew, dragons,
             landpads, launches, launchpads, payloads,
             roadster, rockets, ships, starlink, history
    }
}
