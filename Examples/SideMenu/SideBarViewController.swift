import UIKit

class SideBarViewController: UIViewController {

	@IBOutlet weak var trailingConstraint: NSLayoutConstraint!
	@IBOutlet weak var leadingConstraint: NSLayoutConstraint!
	var menuShowing = false
	var menuWidth: CGFloat = 150
	
	
	@IBAction func View1(_ sender: Any) {
		leadingConstraint.constant = 0
		trailingConstraint.constant = 0
		menuShowing = false
		Util.nav("Gusmano")
	}
	
	@IBOutlet weak var mainView: UIView!
	
	@IBAction func toggleMenu(_ sender: Any) {
		if (menuShowing) {
			leadingConstraint.constant = 0
			trailingConstraint.constant = 0
		}
		else {
			leadingConstraint.constant = menuWidth
			trailingConstraint.constant = -menuWidth
		}
		UIView.animate(withDuration: 0.1,
		               animations: {
										self.view.layoutIfNeeded()
		})
		menuShowing = !menuShowing
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		mainView.layer.shadowOpacity = 1
		mainView.layer.shadowRadius = 10

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
