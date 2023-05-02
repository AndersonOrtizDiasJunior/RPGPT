import SwiftUI
import OpenAISwift
import Combine

final class OpenAI {

    private var localStorage: LocalStorageProtocol
    private var client: OpenAISwift?
    private var chatHistory: [ChatMessage]

    init(localStorage: LocalStorageProtocol = LocalStorage()) {
        self.localStorage = localStorage
        self.chatHistory = localStorage.get(from: .chatHistory, type: [ChatMessage].self) ?? AppConstants.initialChat
    }

    func setup(apiKey: String) {
        client = OpenAISwift(authToken: apiKey)
    }

    func getGPTAnswer(message: String?) -> Future<String, Error> {
        if let message = message {
            saveMessage(message: .init(role: .user, content: message))
        }
        return Future {[weak self] promise in

            self?.client?.sendChat(with: self?.chatHistory ?? [], completionHandler: { result in
                switch result {
                case .success(let result):
                    guard let answer = result.choices?.first?.message.content else {
                        promise(.failure(GPTError.messageError.self))
                        return
                    }
                    self?.saveMessage(message: .init(role: .assistant, content: answer))
                    promise(.success(answer))
                case .failure(let error):
                    promise(.failure(error))
                }
            })
        }
    }

    private func saveMessage (message: ChatMessage) {
        self.chatHistory.append(message)
        return self.localStorage.set(for: .chatHistory, value: self.chatHistory)
    }
}
