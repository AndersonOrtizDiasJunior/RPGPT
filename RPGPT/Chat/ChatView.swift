import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel: ChatViewModel = ChatViewModel()
    @State private var loadingOpacity = 1.0
    
    var body: some View {
        VStack {
            ChatHeaderView()
            
            ScrollView {
                VStack {
                    ForEach(viewModel.messageList) { message in
                        MessageView(message: message)
                    }
                    GettingAnswerView()
                        .isHidden(!viewModel.shouldShowGettingAnswer, remove: true)
                    ErrorMessageView(action: reloadMessage)
                        .isHidden(!viewModel.shouldShowError, remove: true)
                }.rotationEffect(.degrees(180))
            }
            .rotationEffect(.degrees(180))
            .background(Color.gray.opacity(0.1))

            ChatBottomView(action: sendMessage)
                .disabled(viewModel.shouldDisableSendButton())
        }
    }
}

extension ChatView {
    func sendMessage(message: String) {
        withAnimation {
            viewModel.messageList.append(ChatViewMessage(type: .user, content: message))
            withAnimation {
                viewModel.getGTPAnswer(message)
            }
        }
    }

    func reloadMessage() {
        withAnimation {
            withAnimation {
                viewModel.getGTPAnswer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChatView()
                .previewInterfaceOrientation(.portraitUpsideDown)
        }
    }
}
