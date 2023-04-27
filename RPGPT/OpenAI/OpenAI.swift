import SwiftUI
import OpenAISwift
import Combine

final class OpenAI {

    private var client: OpenAISwift?
    private var chatHistory: [ChatMessage] = AppConstants.initialChat

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
