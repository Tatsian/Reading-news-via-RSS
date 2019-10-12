import UIKit
import FeedKit

class OneNewsViewController: UIViewController {

    var article: RSSFeedItem?
    
    @IBOutlet weak var imageOneNews: UIImageView!
    @IBOutlet weak var titleOneNews: UILabel!
    @IBOutlet weak var descriptionOneNews: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let articleOpened = article else { return}
        titleOneNews.text = articleOpened.title
        descriptionOneNews.text = articleOpened.description
        
        let url = URL(string: (articleOpened.enclosure?.attributes!.url)!)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        imageOneNews.image = UIImage(data: data!)
  
    }
}
