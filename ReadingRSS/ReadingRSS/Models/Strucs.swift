
import Foundation

struct NewModel: Codable {
    let rss: Rss
}

struct Rss: Codable {
    let channel: Channel
    let xmlnsYandex: URL
    let xmlnsMedia: URL
    let version: String
    private enum CodingKeys: String, CodingKey {
        case channel
        case xmlnsYandex = "_xmlns:yandex"
        case xmlnsMedia = "_xmlns:media"
        case version = "_version"
    }
}

struct Channel: Codable {
    let title: String
    let about: URL
    let description: String
    let link: URL
    let item: [Item]
}


struct Item: Codable {
    let title: String
    let link: URL
    let amplink: URL
    let description: String
    let pubDate: String
    let category: String
    let enclosure: [Enclosure]
    let fullText: FullText
    let group: Group?
    private enum CodingKeys: String, CodingKey {
        case title
        case link
        case amplink
        case description
        case pubDate
        case category
        case enclosure
        case fullText = "full-text"
        case group
    }
}


struct Enclosure: Codable {
    let url: URL
    let type: String
    let width: String
    let height: String
    private enum CodingKeys: String, CodingKey {
        case url = "_url"
        case type = "_type"
        case width = "_width"
        case height = "_height"
    }
}

struct FullText: Codable {
    let prefix: String
    let text: String
    private enum CodingKeys: String, CodingKey {
        case prefix = "__prefix"
        case text = "__text"
    }
}
struct Group: Codable {
    
    let content: Content
    
    let thumbnail: Thumbnail
    let prefix: String
    private enum CodingKeys: String, CodingKey {
        case content
        case thumbnail
        case prefix = "__prefix"
    }
}

struct Content: Codable {
    let url: URL
    let type: String
    let prefix: String
    private enum CodingKeys: String, CodingKey {
        case url = "_url"
        case type = "_type"
        case prefix = "__prefix"
    }
}

struct Thumbnail: Codable {
    let url: URL
    let type: String
    let prefix: String
    private enum CodingKeys: String, CodingKey {
        case url = "_url"
        case type = "_type"
        case prefix = "__prefix"
    }
}





