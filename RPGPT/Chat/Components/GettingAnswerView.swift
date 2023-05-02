import SwiftUI

struct GettingAnswerView: View {
    @State private var loadingOpacity = 1.0

    @ViewBuilder
    var body: some View {
        HStack {
            Spacer()
            Text(AppConstants.gettinAnswerMessage)
                .italic()
                .padding(10)
                .background(Color.gray.opacity(0.15))
                .cornerRadius(10)
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
                .font(.system(size: 13))
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
    }
}
