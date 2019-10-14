import UIKit

class FilterViewController: UIViewController {

    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var categories: [String] = []

    @IBOutlet weak var chooseFilterButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func chooseFilterClikced(_ sender: Any) {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)

        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @objc func doneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }

}

extension FilterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ picverView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    chooseFilterButton.setTitle(categories[row], for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "goToTableView" else { return }
        
      
        
  
    }
}
