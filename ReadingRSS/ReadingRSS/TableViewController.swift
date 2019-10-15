import UIKit

class TableViewController: UITableViewController {
    
    let urlString = "http://www.vesti.ru/vesti.rss"
    var articlesArray: [RSSFeedItem] = []
    var allArticles: [RSSFeedItem] = []
    var categoryArray: [String] = []
    var selectedCategory: String? {
        didSet {
            updateSelectedCategory(newCategory: selectedCategory)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseRSS{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func refreshControlAction(_ sender: Any) {
        parseRSS{
            DispatchQueue.main.async {
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
                print("refresh")
            }
        }
    }
    
    func parseRSS(completionHandler: (()-> Void)?) {
        let url = URL(string: urlString)!
        let parser = FeedParser(URL: url)
        parser.parseAsync(queue: DispatchQueue.global()) { (result) in
            guard let itemsArray = try? result.get().rssFeed?.items else { return }
            let cateriesSet = Set(itemsArray.map({ $0.categories?.first?.value }))
            print(cateriesSet)
            
            self.articlesArray = itemsArray
            print("News count:", self.articlesArray.count)
            
            self.categoryArray = (Array(cateriesSet) as? [String])!
            print(self.categoryArray.count)
            
            DispatchQueue.main.async {
                let filterVC = self.parent as? FilterViewController
                filterVC?.categories = self.categoryArray
            }
            
            self.articlesArray = itemsArray
            self.allArticles = itemsArray

            completionHandler?()
        }
    }
    
    private func updateSelectedCategory(newCategory: String?) {
        articlesArray = allArticles.filter({$0.categories?.first?.value == newCategory})
        tableView.reloadData()

    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesArray.count 
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let article = articlesArray[indexPath.row]
        cell.textLabel?.text = article.title
        guard let myDate = article.pubDate else { return cell}
        cell.detailTextLabel?.text = myDate.asString(style: .medium)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToNews", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "goToNews" else { return}
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        (segue.destination as? OneNewsViewController)?.article = articlesArray[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension Date {
    func asString(style: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
}
