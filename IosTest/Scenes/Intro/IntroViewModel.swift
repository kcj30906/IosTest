import Foundation

final class IntroViewModel {
    var onStartRequested: (() -> Void)?

    func didTapStart() {
        onStartRequested?()
    }
}
