import SwiftUI

struct ChatBottomView: View {
    @State private var messageText = ""
    let action: (String) -> Void

    var body: some View {
        HStack {
            TextField(AppConstants.textBoxMessage, text: $messageText)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .onSubmit {
                    verifyAndAct()
                }

            Button {
                verifyAndAct()
            } label: {
                Image(systemName: "paperplane.fill")
            }
            .font(.system(size: 26))
            .padding(.horizontal, 10)

        }
        .padding()
    }
}

extension ChatBottomView {
    func verifyAndAct() {
        guard messageText != "" else { return }
        action(messageText)
        self.messageText = ""
    }
}

