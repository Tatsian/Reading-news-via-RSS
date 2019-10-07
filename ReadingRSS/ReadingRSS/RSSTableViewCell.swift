
import UIKit

class RSSTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCellView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setUpCell(itemData: Item) {
        titleLabel.text = itemData.title
        descriptionLabel.text = itemData.description
 //       loadImage(url: itemData.???)
    }
    
    func loadImage(url: URL) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            let image = UIImage.init(data: data)
            
            DispatchQueue.main.async {
                self.imageCellView.image = image
            }
        }
        dataTask.resume()
    }
}
