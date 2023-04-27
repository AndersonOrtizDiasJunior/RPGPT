import SwiftUI
import Combine
import OpenAISwift

final class ChatViewModel: ObservableObject {
    let openAI: OpenAI
    private var localStorage: LocalStorage
    private var observer: AnyCancellable?

    @Published var isGettingAnswer: Bool = false

    @Published var messageList: [ChatViewMessage] {
        didSet {
            localStorage.set(for: .messageList, value: messageList)
        }
    }

    init (openAI: OpenAI = OpenAI(), localStorage: LocalStorage = LocalStorage()) {
        self.openAI = openAI
        self.localStorage = localStorage
        self.messageList = localStorage.get(from: .messageList, type: [ChatViewMessage].self) ?? AppConstants.initialMessageList
        self.setup()
    }

    func setup() {
        self.openAI.setup(apiKey: AppConstants.apiKey)
        if messageList.count <= 1 {
            self.getGTPAnswer()
        }
    }

    func getGTPAnswer(_ message: String? = nil) {
        isGettingAnswer = true
        observer = self.openAI.getGPTAnswer(message: message)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.messageList.append(.init(type: .error, content: AppConstants.openAIErrorMessage))
                    print("Error getting GPT Answer:")
                    print(error)
                    self.isGettingAnswer = false
                case .finished:
                    self.isGettingAnswer = false
                    print("Succesfully got GPT Answer")
                }
            } receiveValue: { response in
                self.messageList.append(.init(type: .GPT, content: response))
            }
    }
}
