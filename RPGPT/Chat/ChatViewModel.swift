import SwiftUI
import Combine
import OpenAISwift

final class ChatViewModel: ObservableObject {
    let openAI: OpenAI
    private var localStorage: LocalStorage
    private var observer: AnyCancellable?

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
        let keyHelper = APIKeyHelper()
        self.openAI.setup(apiKey: keyHelper.getAPIKey())
        if messageList.count <= 1 {
            self.getGTPAnswer("Hi")
        }
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
