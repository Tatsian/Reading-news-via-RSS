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
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
