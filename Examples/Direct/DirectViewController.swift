import UIKit

class DirectViewController: UIViewController {

	let label = UILabel(frame: CGRect(x: 0, y: 210, width: 200, height: 21))

	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupViews()


	}
	
	func setupViews() {
		let buttonMenu = UIButton(frame: CGRect(x: 30, y: 40, width: 50, height: 25))
		buttonMenu.backgroundColor = .black
		buttonMenu.setTitle("Menu", for: .normal)
		buttonMenu.addTarget(self, action: #selector(menuAction), for: .touchUpInside)
		view.addSubview(buttonMenu)
		
		label.textAlignment = .center
		label.text = "I'am a test label"
		self.view.addSubview(label)
		
		let button = UIButton(frame: CGRect(x: 30, y: 150, width: 100, height: 50))
		button.backgroundColor = .black
		button.setTitle("Test Button", for: .normal)
		button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
		view.addSubview(button)
		
		view.backgroundColor = UIColor.lightGray
	}
	
	func setupConstraints() {
		
	}
	
	func menuAction(sender: UIButton!) {
		Util.nav("Menu")
	}
	
	func buttonAction(sender: UIButton!) {
		print("Button tapped")
		label.text = "Button tapped"
	}
}
