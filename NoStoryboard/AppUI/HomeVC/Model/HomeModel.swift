//
//  HomeModel.swift
//  NoStoryboard
//
//  Created by Minh on 12/9/25.
//

import Foundation

struct HomeModel:Codable {
    let bannerSlideLinks: [String]
    // likeTourData can contain dictionaries/objects in JSON — decode flexibly
    let likeTourData: [AnyCodable]
}


// AnyCodable: flexible Codable wrapper to decode heterogeneous JSON values
struct AnyCodable: Codable {
    let value: Any

    init(_ value: Any) {
        self.value = value
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            self.value = NSNull()
            return
        }
        if let boolVal = try? container.decode(Bool.self) {
            self.value = boolVal
            return
        }
        if let intVal = try? container.decode(Int.self) {
            self.value = intVal
            return
        }
        if let doubleVal = try? container.decode(Double.self) {
            self.value = doubleVal
            return
        }
        if let stringVal = try? container.decode(String.self) {
            self.value = stringVal
            return
        }
        if let arrayVal = try? container.decode([AnyCodable].self) {
            self.value = arrayVal.map { $0.value }
            return
        }
        if let dictVal = try? container.decode([String: AnyCodable].self) {
            var dict: [String: Any] = [:]
            for (k, v) in dictVal { dict[k] = v.value }
            self.value = dict
            return
        }

        throw DecodingError.dataCorruptedError(in: container, debugDescription: "AnyCodable value cannot be decoded")
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch value {
        case is NSNull:
            try container.encodeNil()
        case let v as Bool:
            try container.encode(v)
        case let v as Int:
            try container.encode(v)
        case let v as Double:
            try container.encode(v)
        case let v as String:
            try container.encode(v)
        case let v as [Any]:
            let encArray = v.map { AnyCodable($0) }
            try container.encode(encArray)
        case let v as [String: Any]:
            let encDict = Dictionary(uniqueKeysWithValues: v.map { ($0, AnyCodable($1)) })
            try container.encode(encDict)
        default:
            let context = EncodingError.Context(codingPath: container.codingPath, debugDescription: "AnyCodable value cannot be encoded")
            throw EncodingError.invalidValue(value, context)
        }
    }
}
