import SwiftUI

struct ErrorMessageView: View {
    let action: () -> ()

    @ViewBuilder
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "exclamationmark.arrow.triangle.2.circlepath")
                .font(.system(size: 26))
                .foregroundColor(Color.red)
        }
        .font(.system(size: 26))
        .padding()
    }
}
