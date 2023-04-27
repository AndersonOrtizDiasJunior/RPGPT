import SwiftUI
import OpenAISwift
import Combine

final class OpenAI {

    private var client: OpenAISwift?
    private var chatHistory: [ChatMessage] = [
        ChatMessage(role: .system, content: "You are a tabletop RPG dungeon master."),
        ChatMessage(role: .user, content: "Hello, Chat GPT! I would like to play an RPG game and I was wondering if you could be my Dungeon Master. Can you create a game setting for me and guide me through the adventure? Also, can you let me know when I should roll a d20 for my actions? You can start by asking me to create a character and letting me describe it and its name"),
    ]

    func setup(apiKey: String) {
        client = OpenAISwift(authToken: apiKey)
    }

    func getGPTAnswer(message: String?) -> Future<String, Error> {
        if let message = message {
            chatHistory.append(.init(role: .user, content: message))
        }
        return Future {[weak self] promise in

            self?.client?.sendChat(with: self?.chatHistory ?? [], completionHandler: { result in
                switch result {
                case .success(let result):
                    guard let answer = result.choices?.first?.message.content else {
                        promise(.failure(GPTError.messageError.self))
                        return
                    }
                    self?.chatHistory.append(.init(role: .assistant, content: answer))
                    promise(.success(answer))
                case .failure(let error):
                    promise(.failure(error))
                }
            })
        }
    }
}
