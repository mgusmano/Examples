import UIKit

class CellViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	@IBAction func menu(_ sender: Any) {Util.nav("Menu")}
	
		var myArray = ["AAA", "BBB", "CCC", "DDD"]
		
		override func viewDidLoad() {
			super.viewDidLoad()
			
			let tableView = UITableView(frame: view.bounds, style: UITableViewStyle.grouped)
			tableView.delegate = self
			tableView.dataSource = self
			view.addSubview(tableView)
		}
		
		override func didReceiveMemoryWarning() {
			super.didReceiveMemoryWarning()
			// Dispose of any resources that can be recreated.
		}
		
		func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
			return 385
		}
		func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
			return myArray.count
		}
		func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
			
			let cell = MyTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "myIdentifier")
			cell.myLabel1.text = "Label1: " + myArray[indexPath.row]
			cell.myLabel2.text = "Label2: " + "\(indexPath.row)"
			cell.myButton1.addTarget(self, action: #selector(pressedBrowser(_:)), for: UIControlEvents.touchUpInside)
			cell.myButton2.addTarget(self, action: #selector(pressedTelephone(_:)), for: UIControlEvents.touchUpInside)
			//cell.myButton1.addTarget(self, action: Selector(("pressedBrowser:")), for: UIControlEvents.touchUpInside)
			//cell.myButton2.addTarget(self, action: Selector(("pressedTelephone:")), for: UIControlEvents.touchUpInside)
			return cell
		}
		
		func pressedBrowser(_ sender: UIButton) {
			print("pressedBrowser")
		}
		
		func pressedTelephone(_ sender: UIButton) {
			print("pressedTelephone")
		}
}
