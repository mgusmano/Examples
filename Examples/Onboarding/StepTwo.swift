import UIKit

class StepTwo : UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Layout.burntOrange
    }
    
    let burgerHeightOriginalState:CGFloat = -10
    
    @IBOutlet weak var burgerAirHeight: NSLayoutConstraint!
    @IBOutlet weak var burger: UIImageView!
    
    
    @IBAction func NeverShowAgainAndGetStarted(_ sender: Any) {
        GeneralSettings.saveOnboardingFinished()
        Util.nav("Menu")
        
    }
    
    @IBAction func getStarted(_ sender: Any) {
        Util.nav("Menu")
//        let name = "Menu"
//        let storyboard = UIStoryboard(name: name, bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: name)
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = vc
//        appDelegate.window?.makeKeyAndVisible()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // reset animation to starting point
        // so user can scroll back and re-watch.
        burgerAirHeight.constant = burgerHeightOriginalState
        burger?.transform = CGAffineTransform(rotationAngle: 0)
        
        // this hacky delay is so the screen gets its stuff in order before we start animating.
        // otherwise the entire screen starts morphing in strange ways.
        HelperLibrary.delay(seconds: 0.5, completion: {
            
            // burger goes up
            // not meant to be precise like newton's law
            UIView.animate(withDuration: 0.5,
                delay: 0.0,
                options: .curveEaseOut,
                animations: {
                    // constraints don't get animated by default, so you need layoutIfNeeded()
                    self.burgerAirHeight.constant = 100
                    self.view.layoutIfNeeded()
                    // flip the burger
                    self.burger?.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                },
                completion: nil
            )
            
            // burger goes down
            UIView.animate(withDuration: 0.5,
                delay: 0.5,
                options: .curveEaseIn,
                animations: {
                    // again, using layoutIfNeeded() for animating constraints
                    self.burgerAirHeight.constant = self.burgerHeightOriginalState
                    self.view.layoutIfNeeded()
                    // flip the tofu
                    self.burger?.transform = CGAffineTransform(rotationAngle: 0)
                },
                completion: nil
            )
            
        })
        
    }
    
}
