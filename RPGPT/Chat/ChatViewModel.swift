//
//  ChatViewModel.swift
//  RPGPT
//
//  Created by Anderson Ortiz Dias Junior on 26/04/23.
//
import SwiftUI
import Combine

final class ChatViewModel: ObservableObject {
    let openAI: OpenAI
    @Published var messages: [String] = []
    @Published var messageList: [String] = ["[USER]Let's play RPG?"]

    private var observer: AnyCancellable?

    init (openAI: OpenAI = OpenAI()) {
        self.openAI = openAI
        self.setup()
//        $messages
//            .map{ $0.isEmpty ? [] : $0}
//            .assign(to: &$messageList)
    }

    func setup() {
        self.openAI.setup(apiKey: AppConstants.apiKey)
        return self.getGTPAnswer("Hi")
    }

    private func getGTPAnswer(_ message: String) {
        observer = self.openAI.getGPTAnswer(message: message).sink { completion in
            switch completion {
            case .failure(let error):
                print("gpt gone wrong")
                self.messageList.append(AppConstants.openAIErrorMessage)
            case .finished:
                print("Succesfully got GPT Answer")
            }
        } receiveValue: { response in
            self.messageList.append(response)
        }
    }
}
