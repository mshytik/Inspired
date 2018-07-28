import Foundation
import Security

// MARK: Keychain

final class Keychain {
    
    // MARK: Interface
    
    static func get(key: String) -> String? {
        guard let data = getData(key: key) else { return nil }
        return NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) as String?
    }
    
    static func set(key: String, value: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        return setData(key: key, value: data as NSData)
    }
    
    static func delete(key: String) -> Bool {
        let item = query([(kSecAttrAccount as String): key as NSString])
        return SecItemDelete(item) == noErr
    }
    
    static func clear() -> Bool {
        let item = query([:])
        return SecItemDelete(item) == noErr
    }
    
    // MARK: Private
    
    private static func getData(key: String) -> NSData? {
        let item = query([(kSecAttrAccount as String): key as NSString,
                          (kSecReturnData as String): kCFBooleanTrue,
                          (kSecMatchLimit as String): kSecMatchLimitOne])
        var data : AnyObject?
        let status = withUnsafeMutablePointer(to: &data) { ptr in SecItemCopyMatching(item, UnsafeMutablePointer(ptr)) }
        return (status == noErr) ? (data as? NSData) : nil
    }
    
    static func setData(key: String, value: NSData) -> Bool {
        let item = query([(kSecAttrAccount as String): key as NSString, (kSecValueData as String): value])
        SecItemDelete(item)
        return SecItemAdd(item, nil) == noErr
    }
    
    private static func query(_ query: [String : AnyObject]) -> CFDictionary {
        var output = query
        output[kSecClass as String] = kSecClassGenericPassword
        output[kSecAttrService as String] = (Bundle.main.bundleIdentifier ?? "" + ".unsplash.auth") as NSString
        return output as CFDictionary
    }
}

