import SwiftUI

struct ChatHeaderView: View {

    var body: some View {
        HStack {
            Text(AppConstants.appName)
                .font(.largeTitle)
                .bold()

            Image(systemName: "bubble.left.fill")
                .font(.system(size: 26))
                .foregroundColor(Color.blue)
        }
    }
}
