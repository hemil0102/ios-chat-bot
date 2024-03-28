import Foundation

protocol JsonEncodableProtocol {
    func encode<T: Encodable>(of file: T) -> Result<Data?, NetworkError>
}

