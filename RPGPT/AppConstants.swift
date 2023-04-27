import Foundation

struct AppConstants {
    static let apiKey = ProcessInfo.processInfo.environment["API_KEY"] ?? ""
    static let openAIErrorMessage = "Sorry, error getting answer. Please try Again"
}
