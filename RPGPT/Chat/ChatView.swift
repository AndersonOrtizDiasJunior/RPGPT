import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel: ChatViewModel = ChatViewModel()
    @State private var messageText = ""
    @State private var loadingOpacity = 1.0
    
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
                VStack {
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
                                Button {
                                    reloadMessage()
                                } label: {
                                    Image(systemName: "exclamationmark.arrow.triangle.2.circlepath")
                                        .font(.system(size: 26))
                                        .foregroundColor(Color.red)
                                }
                                .font(.system(size: 26))
                                Spacer()
                                Spacer()
                            }
                        }
                    }
                    HStack {
                            Spacer()
                            Text("generating answer...")
                                .italic()
                                .padding(10)
                                .background(Color.gray.opacity(0.15))
                                .cornerRadius(10)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 10)
                                .font(.system(size: 13))
                                .isHidden(!viewModel.isGettingAnswer, remove: true)
                                .opacity(loadingOpacity)
                                      .onAppear {
                                          withAnimation(Animation.easeInOut(duration: 1.0).repeatForever()) {
                                              self.loadingOpacity = 0.5
                                          }
                                      }
                                      .onDisappear {
                                          self.loadingOpacity = 1
                                      }
                            Spacer()
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
                    guard messageText != "" else { return }
                    sendMessage(message: messageText)
                } label: {
                    Image(systemName: "paperplane.fill")
                }
                .font(.system(size: 26))
                .padding(.horizontal, 10)
                .disabled(viewModel.isGettingAnswer)

            }
            .padding()
        }
    }
    
    func sendMessage(message: String) {
        withAnimation {
            viewModel.messageList.append(ChatViewMessage(type: .user, content: message))
            self.messageText = ""
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
