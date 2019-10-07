
import Foundation

struct ItemData {
    var title: String
    var link: URL
    var amplink: URL
    var description: String
    var pubDate: Date
    var category: String
    var enclosure: String //??
    var yandexFullText: String
    private enum CodingKeys: String, CodingKey {
        case title
        case link
        case amplink
        case description
        case pubDate
        case category
        case enclosure
        case yandexFullText = "yandex:full-text"
    }
    
    
}
