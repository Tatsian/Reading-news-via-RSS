import UIKit

class OneNewsViewController: UIViewController {

    var article: RSSFeedItem?
    
    @IBOutlet weak var imageOneNews: UIImageView!
    @IBOutlet weak var titleOneNews: UILabel!
    @IBOutlet weak var descriptionOneNews: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let articleOpened = article else { return }
        titleOneNews.text = articleOpened.title
        descriptionOneNews.text = articleOpened.yandexFullText
 
        DispatchQueue.global().async {
            guard let imageURL = articleOpened.enclosure?.attributes?.url,
                let url = URL(string: imageURL),
                let data = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                self.imageOneNews.image = UIImage(data: data)
            }
        }
    }
}
