import Foundation

struct ChatViewMessage: Identifiable, Codable {
    let id = UUID()
    let type: ChatViewMessageType
    let content: String
}
