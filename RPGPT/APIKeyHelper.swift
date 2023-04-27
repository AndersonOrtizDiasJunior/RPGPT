import Foundation

final class APIKeyHelper {
    private var localStorage: LocalStorage

    init (localStorage: LocalStorage = LocalStorage()) {
        self.localStorage = localStorage
    }

    func getAPIKey() -> String {
        guard let key = localStorage.get(from: .apiKey) ?? ProcessInfo.processInfo.environment["API_KEY"] else {
            return ""
        }
        localStorage.set(for: .apiKey, value: key)
        return key
    }
}
