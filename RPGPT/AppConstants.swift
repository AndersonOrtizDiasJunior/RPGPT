import Foundation
import OpenAISwift

struct AppConstants {
    static let apiKey = ProcessInfo.processInfo.environment["API_KEY"] ?? ""

    static let gettinAnswerMessage = "generating answer..."
    static let appName = "RPGPT"
    static let textBoxMessage = "Type something"

    static let initialChat: [ChatMessage] = [
        ChatMessage(role: .system, content: "You are a tabletop RPG dungeon master."),
        ChatMessage(role: .user, content: "Hello, Chat GPT! I would like to play an RPG game and I was wondering if you could be my Dungeon Master. Can you create a game setting for me and guide me through the adventure? Also, can you roll a d20 for my actions when needed? "),
        ChatMessage(role: .assistant, content: "Sure, I will roll the dice for you when needed."),
        ChatMessage(role: .user, content: "Alright, but can you always ask me first? it gives a most immersive atmosphere if you ask 'Can I roll a d20 for you' before rolling."),
        ChatMessage(role: .assistant, content: "Of course. Every time a dice roll is needed I will let you now and then ask if you want me to roll for you"),
        ChatMessage(role: .user, content: "Perfect, so shall we begin? You can start by asking me to create a character and letting me describe it and its name")
    ]
    static let initialMessageList: [ChatViewMessage] = [.init(type: .user, content: "Let's play RPG?")]
}
