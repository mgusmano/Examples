import UIKit

class OrientationViewController: UIViewController {

	@IBAction func Menu(_ sender: Any) {
		Util.nav("Menu")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	
	override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
		var text=""
		switch UIDevice.current.orientation{
		case .portrait:
			text="Portrait"
		case .portraitUpsideDown:
			text="PortraitUpsideDown"
		case .landscapeLeft:
			text="LandscapeLeft"
		case .landscapeRight:
			text="LandscapeRight"
		default:
			text="Another"
		}
		print("You have moved: \(text)")
		let screenSize: CGRect = UIScreen.main.bounds
		let screenWidth = screenSize.size.width
		let screenHeight = screenSize.size.height
		
		print("width")
		print(screenWidth)
		print("height")
		print(screenHeight)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		print("viewWillAppear")
		print(UIDevice.current.orientation.isPortrait)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		print("viewDidAppear")
		print(UIDevice.current.orientation.isPortrait)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		print("viewWillDisappear")
		print(UIDevice.current.orientation.isPortrait)
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		print("viewDidDisappear")
		print(UIDevice.current.orientation.isPortrait)
	}
	

}
