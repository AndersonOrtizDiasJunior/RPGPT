import Foundation
final class LocalStorage: LocalStorageProtocol {


    func get<T>(from key: LocalStorageKeys, type: T.Type) -> T? {
       UserDefaults.standard.object(forKey: key.rawValue) as? T
    }

    func get<T: Decodable>(from key: LocalStorageKeys, type: T.Type) -> T? {
        let decoder = JSONDecoder()
        guard let data = UserDefaults.standard.object(forKey: key.rawValue) as? Data else { return nil }
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            print("Error decoding from localStorage: \(error.localizedDescription)")
            return nil
        }
    }

    func set(for key: LocalStorageKeys, value: Any) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }

    func set<T: Encodable>(for key: LocalStorageKeys, value: T) {
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(value) else {
            print("Error saving to Local Storage")
            return
        }
        UserDefaults.standard.set(encoded, forKey: key.rawValue)
    }
}
