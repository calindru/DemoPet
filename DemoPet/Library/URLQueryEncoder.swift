//
//  URLQueryEncoder.swift
//  DemoPet
//
//  Created by Calin Drule on 12.02.2024.
//

import Foundation

struct URLQueryEncoder {
    func encode<T: Encodable>(_ value: T) throws -> Data {
        let encoder = _URLQueryEncoder()
        try value.encode(to: encoder)
        let encodedString = encoder.components.joined(separator: "&")
        
        guard let data = encodedString.data(using: .utf8)  else {
            throw APIError.encodingFailed
        }
        
        return data
    }
    
    func urlEncode<T: Encodable>(_ value: T) throws -> Data {
        let encoder = _URLQueryEncoder()
        try value.encode(to: encoder)
        let encodedString = encoder.components.joined(separator: "&").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        guard let data = encodedString.data(using: .utf8)  else {
            throw APIError.encodingFailed
        }
        
        return data
    }
}

fileprivate class _URLQueryEncoder: Encoder {
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        KeyedEncodingContainer(KVC<Key>(encoder: self))
    }
    
    func unkeyedContainer() -> UnkeyedEncodingContainer {
        fatalError("Unkeyed encoding is not supported.")
    }
    
    func singleValueContainer() -> SingleValueEncodingContainer {
        return self
    }
    
    var codingPath: [CodingKey] = []
    var userInfo: [CodingUserInfoKey : Any] = [:]
    var components: [String] = []
}

extension _URLQueryEncoder: SingleValueEncodingContainer {
    func encodeNil() throws {}
    
    func encode<T>(_ value: T) throws where T : Encodable {
        if let stringValue = value as? CustomStringConvertible {
            components.append("\(stringValue.description)")
        } else {
            throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: codingPath, debugDescription: "Value is not a CustomStringConvertible"))
        }
    }
}

fileprivate class KVC<Key: CodingKey>: KeyedEncodingContainerProtocol {
    var codingPath: [CodingKey] = []
    var encoder: _URLQueryEncoder
    
    init(encoder: _URLQueryEncoder) {
        self.encoder = encoder
    }
    
    func encodeNil(forKey key: Key) throws {}
    
    func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable {
        if let stringValue = value as? CustomStringConvertible {
            encoder.components.append("\(key.stringValue)=\(stringValue.description)")
        } else {
            let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Value for key '\(key.stringValue)' is not a CustomStringConvertible")
            throw EncodingError.invalidValue(value, context)
        }
    }
    
    func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        fatalError("Nested encoding is not supported.")
    }
    
    func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        fatalError("Nested encoding is not supported.")
    }
    
    func superEncoder() -> Encoder {
        return encoder
    }
    
    func superEncoder(forKey key: Key) -> Encoder {
        return encoder
    }
}
