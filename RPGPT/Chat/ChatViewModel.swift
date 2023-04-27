import SwiftUI
import Combine

final class ChatViewModel: ObservableObject {
    let openAI: OpenAI
    @Published var messages: [String] = []
    @Published var messageList: [ChatViewMessage] = [.init(type: .user, content: "Let's play RPG?")]

    private var observer: AnyCancellable?

    init (openAI: OpenAI = OpenAI()) {
        self.openAI = openAI
        self.setup()
    }

    func setup() {
        self.openAI.setup(apiKey: AppConstants.apiKey)
        return self.getGTPAnswer("Hi")
    }

    func getGTPAnswer(_ message: String) {
        observer = self.openAI.getGPTAnswer(message: message)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.messageList.append(.init(type: .error, content: AppConstants.openAIErrorMessage))
                    print("Error getting GPT Answer:")
                    print(error)
                case .finished:
                    print("Succesfully got GPT Answer")
                }
            } receiveValue: { response in
                self.messageList.append(.init(type: .GPT, content: response))
            }
    }
}
