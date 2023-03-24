import Combine

enum MainEvent {
    case didLoadSections(MainContent)
}

enum MainAction {
    case fetch
}

final class MainStore: Store<MainEvent, MainAction> {
    override func handleActions(action: MainAction) {
        switch action {
        case .fetch:
            statefulCall(fetch)
        }
    }
    
    private func fetch() async throws {
        let latest: LatestResponse = try await APIClient.shared.makeRequest(path: "cc0071a1-f06e-48fa-9e90-b1c2a61eaca7")
        let flash: FlashResponse = try await APIClient.shared.makeRequest(path: "a9ceeb6e-416d-4352-bde6-2203416576ac")
        sendEvent(.didLoadSections(MainContent(latest: latest.latest, flash: flash.flash_sale, brands: latest.latest.reversed())))
    }
}
