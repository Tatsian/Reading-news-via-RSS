//
//  fromVC.swift
//  ReadingRSS
//
//  Created by Tatsiana on 10.10.2019.
//  Copyright © 2019 Tati. All rights reserved.
//

import Foundation
import FeedKit


let urlString = "http://www.vesti.ru/vesti.rss"
var articlesArray: [RSSFeedItem] = []
var categoryArray = [String]()


func parseRSS(completionHandler: (()-> Void)?) {
    let url = URL(string: urlString)!
    let parser = FeedParser(URL: url)
    parser.parseAsync(queue: DispatchQueue.global()) { (result) in
        let items = result.rssFeed?.items
        guard let itemsArray = items else { return }
        articlesArray = itemsArray
        print("News count:", items?.count)
        print("Error", result.error)

        completionHandler?()

    }
    
    func dateToDateFormat(dateString: String) {
        let dateString = "Thu, 22 Oct 2015 07:45:17 +0000"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy hh:mm:ss +zzzz"
        dateFormatter.locale = Locale.init(identifier: "en_GB")

        let dateObj = dateFormatter.date(from: dateString)

        dateFormatter.dateFormat = "MM-dd-yyyy"
        print("Dateobj: \(dateFormatter.string(from: dateObj!))")
    }
}
