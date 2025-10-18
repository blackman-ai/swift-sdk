import Foundation

/// A type-erased Codable value for handling arbitrary JSON
public struct AnyCodable: Codable, Equatable, Hashable {
    public let value: Any

    public init<T>(_ value: T?) {
        self.value = value ?? ()
    }

    public static func == (lhs: AnyCodable, rhs: AnyCodable) -> Bool {
        switch (lhs.value, rhs.value) {
        case is (Void, Void): return true
        case let (lhs as Bool, rhs as Bool): return lhs == rhs
        case let (lhs as Int, rhs as Int): return lhs == rhs
        case let (lhs as Double, rhs as Double): return lhs == rhs
        case let (lhs as String, rhs as String): return lhs == rhs
        case let (lhs as [String: AnyCodable], rhs as [String: AnyCodable]): return lhs == rhs
        case let (lhs as [AnyCodable], rhs as [AnyCodable]): return lhs == rhs
        default: return false
        }
    }

    public func hash(into hasher: inout Hasher) {
        switch value {
        case let value as Bool: hasher.combine(value)
        case let value as Int: hasher.combine(value)
        case let value as Double: hasher.combine(value)
        case let value as String: hasher.combine(value)
        case let value as [String: AnyCodable]: hasher.combine(value)
        case let value as [AnyCodable]: hasher.combine(value)
        default: break
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            self.init(())
        } else if let bool = try? container.decode(Bool.self) {
            self.init(bool)
        } else if let int = try? container.decode(Int.self) {
            self.init(int)
        } else if let double = try? container.decode(Double.self) {
            self.init(double)
        } else if let string = try? container.decode(String.self) {
            self.init(string)
        } else if let array = try? container.decode([AnyCodable].self) {
            self.init(array)
        } else if let dictionary = try? container.decode([String: AnyCodable].self) {
            self.init(dictionary)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode AnyCodable")
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch value {
        case is Void: try container.encodeNil()
        case let bool as Bool: try container.encode(bool)
        case let int as Int: try container.encode(int)
        case let double as Double: try container.encode(double)
        case let string as String: try container.encode(string)
        case let array as [Any?]: try container.encode(array.map { AnyCodable($0) })
        case let dictionary as [String: Any?]: try container.encode(dictionary.mapValues { AnyCodable($0) })
        default:
            throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: container.codingPath, debugDescription: "Cannot encode AnyCodable"))
        }
    }
}
