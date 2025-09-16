// LocalJSONLoader.swift
// Utility to load local JSON files and decode using Codable

import Foundation

enum LocalJSONLoaderError: Error {
    case resourceNotFound(String)
    case dataReadFailed(Error)
    case decodeFailed(Error)
}

final class LocalJSONLoader {
    /// Load and decode a JSON file embedded in the app bundle.
    /// - Parameters:
    ///   - type: Decodable type to decode to
    ///   - resource: filename without extension
    ///   - subdirectory: optional bundle subdirectory (e.g. "LocalData")
    /// - Returns: decoded model of type T
    static func load<T: Decodable>(_ type: T.Type, fromResource resource: String, subdirectory: String? = nil) throws -> T {
        let bundle = Bundle.main
        guard let url = bundle.url(forResource: resource, withExtension: "json", subdirectory: subdirectory) ?? bundle.url(forResource: resource, withExtension: "json") else {
            throw LocalJSONLoaderError.resourceNotFound(resource)
        }

        do {
            let data = try Data(contentsOf: url)
            do {
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: data)
            } catch {
                throw LocalJSONLoaderError.decodeFailed(error)
            }
        } catch {
            throw LocalJSONLoaderError.dataReadFailed(error)
        }
    }
}
