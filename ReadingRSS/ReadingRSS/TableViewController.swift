
import UIKit
import FeedKit

class TableViewController: UITableViewController {

    let urlString = "http://www.vesti.ru/vesti.rss"
    var articlesArray: [RSSFeedItem] = []
    var categoryArray = [String]()
    
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
        let items = result.rssFeed?.items
        guard let itemsArray = items else { return }
        self.articlesArray = itemsArray
        print("News count:", items?.count)
        print("Error", result.error)

        completionHandler?()
    }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "goToNews" else { return}
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        (segue.destination as? OneNewsViewController)?.article = articlesArray[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)

    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */






}

extension Date {
  func asString(style: DateFormatter.Style) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = style
    return dateFormatter.string(from: self)
  }
}
