import Foundation

enum Section {
    case main
}

struct ChatDisplayModel: Hashable {
    let id: UUID = UUID()
    let content: String
}
