import Foundation

extension KeyedDecodingContainer {

    func decode<T: Decodable>(_ key: KeyedDecodingContainer.Key) throws -> T {
        return try decode(T.self, forKey: key)
    }

    func decodeIfPresent<T: Decodable>(_ key: KeyedDecodingContainer.Key) throws -> T? {
        return try decodeIfPresent(T.self, forKey: key)
    }
}
