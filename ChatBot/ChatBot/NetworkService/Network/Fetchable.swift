import Foundation
import Combine

protocol Fetchable {
    func fetchData() -> AnyPublisher<Data, Error>
}
