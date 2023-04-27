import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel: ChatViewModel = ChatViewModel()
    @State private var messageText = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("RPGPT")
                    .font(.largeTitle)
                    .bold()
                
                Image(systemName: "bubble.left.fill")
                    .font(.system(size: 26))
                    .foregroundColor(Color.blue)
            }
            
            ScrollView {
                ForEach(viewModel.messageList) { message in
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
                    case .error:
                        HStack {
                            Text(message.content)
                                .padding()
                                .background(Color.red.opacity(0.15))
                                .cornerRadius(10)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 10)
                            Spacer()
                        }
                    }
                    
                }.rotationEffect(.degrees(180))
            }
            .rotationEffect(.degrees(180))
            .background(Color.gray.opacity(0.1))

            HStack {
                TextField("Type something", text: $messageText)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .onSubmit {
                        sendMessage(message: messageText)
                    }
                
                Button {
                    sendMessage(message: messageText)
                } label: {
                    Image(systemName: "paperplane.fill")
                }
                .font(.system(size: 26))
                .padding(.horizontal, 10)
            }
            .padding()
        }
    }
    
    func sendMessage(message: String) {
        withAnimation {
            viewModel.messageList.append(ChatViewMessage(type: .user, content: message))
            self.messageText = ""
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    viewModel.getGTPAnswer(message)
                }
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
