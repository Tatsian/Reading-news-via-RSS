
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var newsTable: UITableView!
    
    let urlString = "http://www.vesti.ru/vesti.rss"
    var articlesArray: [Item] = []
    
    override func viewDidAppear(_ animated: Bool) {

        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barStyle = UIBarStyle.black
        downloadData()
    }
    
    

    func downloadData() {
        guard let url = URL(string: urlString) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            guard let data = data else { return }
            self.parse(data: data)
            
            DispatchQueue.main.async {
                self.newsTable.reloadData()
            }
        }
        dataTask.resume()
    }

    func parse(data: Data) {
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? RSSTableViewCell else { return UITableViewCell()}
        
        cell.setUpCell(itemData: articlesArray[indexPath.row])
        return cell
    }
    
    
}

