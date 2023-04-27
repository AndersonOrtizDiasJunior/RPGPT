import Foundation

struct ChatViewMessage: Identifiable {
    let id = UUID()
    let type: ChatViewMessageType
    let content: String
}
