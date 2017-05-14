import UIKit

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

	func go(to: String) {
		leadingConstraint.constant = 0
		trailingConstraint.constant = 0
		Util.nav(to)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return menus.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: HomeMenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HomeMenu", for: indexPath) as! HomeMenuTableViewCell
		cell.textLabel?.text = menus[indexPath.row].title
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print(menus[indexPath.row].storyboard)
		let selectedItem = menus[indexPath.row].storyboard
		go(to: selectedItem)
	}
}
