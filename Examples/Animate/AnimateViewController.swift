import UIKit

class AnimateViewController: UIViewController {
	
	// http://jamesonquave.com/blog/designing-animations-with-uiviewpropertyanimator-in-ios-10-and-swift-3/
	
	// this records our circle's center for use as an offset while dragging
	var circleCenter: CGPoint!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Add a draggable view
		let circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
		circle.center = self.view.center
		circle.layer.cornerRadius = 50.0
		circle.backgroundColor = UIColor.green
		
		// add pan gesture recognizer to
		circle.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.dragCircle)))
		
		self.view.addSubview(circle)
	}
	
	func dragCircle(gesture: UIPanGestureRecognizer) {
		let target = gesture.view!
		
		switch gesture.state {
		case .began, .ended:
			circleCenter = target.center
		case .changed:
			let translation = gesture.translation(in: self.view)
			target.center = CGPoint(x: circleCenter!.x + translation.x, y: circleCenter!.y + translation.y)
		default: break
		}
	}
}
