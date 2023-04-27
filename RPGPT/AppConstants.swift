import Foundation
import OpenAISwift

struct AppConstants {
    static let apiKey = ProcessInfo.processInfo.environment["API_KEY"] ?? ""

    static let openAIErrorMessage = "Sorry, error getting answer. Please try Again"

    static let initialChat: [ChatMessage] = [
        ChatMessage(role: .system, content: "You are a tabletop RPG dungeon master."),
        ChatMessage(role: .user, content: "Hello, Chat GPT! I would like to play an RPG game and I was wondering if you could be my Dungeon Master. Can you create a game setting for me and guide me through the adventure? Also, can you let me know when I should roll a d20 for my actions? You can start by asking me to create a character and letting me describe it and its name"),
    ]
    static let initialMessageList: [ChatViewMessage] = [.init(type: .user, content: "Let's play RPG?")]
}
