import Foundation

enum DataModelStatus {
    case initializing
    case loading
    case done
    case error
}

protocol Statused {
    var status: DataModelStatus { get }
}
