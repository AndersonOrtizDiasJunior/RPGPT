import SwiftUI
import Combine
import OpenAISwift

final class ChatViewModel: ObservableObject {
    let openAI: OpenAI
    private var localStorage: LocalStorageProtocol
    private var observer: AnyCancellable?

    @Published var shouldShowGettingAnswer: Bool = false
    @Published var shouldShowError: Bool {
        didSet {
            localStorage.set(for: .shouldShowError, value: shouldShowError)
        }
    }

    @Published var messageList: [ChatViewMessage] {
        didSet {
            localStorage.set(for: .messageList, value: messageList)
        }
    }

    init (openAI: OpenAI = OpenAI(), localStorage: LocalStorageProtocol = LocalStorage()) {
        self.openAI = openAI
        self.localStorage = localStorage
        self.messageList = localStorage.get(from: .messageList, type: [ChatViewMessage].self) ?? AppConstants.initialMessageList
        self.shouldShowError = localStorage.get(from: .shouldShowError, type: Bool.self) ?? false
        self.setup()
    }

    func setup() {
        self.openAI.setup(apiKey: AppConstants.apiKey)
        if messageList.count <= 1 {
            self.getGTPAnswer()
        }
    }

    func getGTPAnswer(_ message: String? = nil) {
        shouldShowGettingAnswer = true
        shouldShowError = false
        observer = self.openAI.getGPTAnswer(message: message)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.shouldShowError = true
                    print("Error getting GPT Answer:")
                    print(error)
                    self.shouldShowGettingAnswer = false
                case .finished:
                    self.shouldShowGettingAnswer = false

                    print("Succesfully got GPT Answer")
                }
            } receiveValue: { response in
                self.messageList.append(.init(type: .GPT, content: response))
            }
    }

    func shouldDisableSendButton() -> Bool {
        self.shouldShowError || self.shouldShowGettingAnswer
    }
}
