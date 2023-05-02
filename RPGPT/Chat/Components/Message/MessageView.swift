import SwiftUI

struct MessageView: View {
    private var message: ChatViewMessage

    init(message: ChatViewMessage) {
        self.message = message
    }

    @ViewBuilder
    var body: some View {
        switch message.type {
        case .user:
            HStack {
                Spacer()
                Text(message.content)
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.blue.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 10)
            }
        case .GPT:
            HStack {
                Text(message.content)
                    .padding()
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 10)
                Spacer()
            }
        }
    }
}

