import UIKit

extension BeaconsDetailViewController {
	
	
	func setNavigationBar(title: String) {
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.isTranslucent = true
		self.navigationController?.view.backgroundColor = UIColor.clear
	}
	

	
}
