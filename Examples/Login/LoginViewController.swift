import UIKit
import AVFoundation

class LoginViewController: UIViewController, AVAudioPlayerDelegate {

    
    @IBAction func btnMenu(_ sender: Any) {
       Util.nav("Menu")
    }
    
    
//    @IBOutlet weak var nameTextField: UITextField!
//    @IBOutlet weak var passwordTextField: UITextField!
//    @IBOutlet weak var loginButton: UIButton!
//    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var playedTime: UILabel!

    var audioPlayer = AVAudioPlayer()
    var timer:Timer!
    var timer2:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "HotelCalifornia", ofType: "m4a")!))
            //audioPlayer.delegate = self
            //audioPlayer.prepareToPlay()
            audioPlayer.setVolume(1, fadeDuration: 0)
            self.audioPlayer.play()
            audioPlayer.setVolume(0, fadeDuration: 5)
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(LoginViewController.updateTime), userInfo: nil, repeats: true)
        }
        catch {
            print("***********")
            print(error)
        }
        
//        loginButton.layer.cornerRadius = 8.0
    }
    
    func updateTime(timer: Timer) {
        let currentTime = Int(audioPlayer.currentTime)
        let minutes = currentTime/60
        let seconds = currentTime - minutes * 60
        
        if (seconds == 5) {
            audioPlayer.stop()
            timer.invalidate()
        }
        playedTime.text = NSString(format: "%02d:%02d", minutes,seconds) as String
    }
    
    @IBAction func play(_ sender: Any) {
        audioPlayer.setVolume(1, fadeDuration: 2)
        audioPlayer.play()
    }
    @IBAction func pause(_ sender: Any) {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
        }
        else {
            
        }
    }
    @IBAction func restart(_ sender: Any) {
        if audioPlayer.isPlaying {
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            audioPlayer.setVolume(1, fadeDuration: 2)
            audioPlayer.play()
        }
        else {
            audioPlayer.setVolume(1, fadeDuration: 2)
            audioPlayer.play()
        }
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        print("viewWillAppear")
//        loginButton.center.x -= view.bounds.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("viewDidAppear")

//        UIView.animate(withDuration: 3.0, delay: 0.0, options: [],
//          animations: { self.lblTitle.alpha += 1 },
//          completion: {
//            (value: Bool) in
//          }
//        )
        
//        UIView.animate(withDuration: 0.5, delay: 0.0, options: [],
//            animations: { self.loginButton.center.x += self.view.bounds.width },
//            completion: nil
//        )
    }

//    func updateTime2(timer: Timer) {
//        if (audioPlayer.currentTime > 110.3) {
//            audioPlayer.stop()
//            timer.invalidate()
//            
//            
////            let name = "Navigation"
////            let storyboard = UIStoryboard(name: name, bundle: nil)
////            let vc = storyboard.instantiateViewController(withIdentifier: name) as! UINavigationController
////            vc.username = username
////            vc.password = password
////            let appDelegate = UIApplication.shared.delegate as! AppDelegate
////            appDelegate.window?.rootViewController = vc
//            
////            let username = self.nameTextField.text
////            let password = self.passwordTextField.text
//            let name = "Cloud"
//            let storyboard = UIStoryboard(name: name, bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: name) as! CloudTableViewController
//            vc.username = username!
//            vc.password = password!
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window?.rootViewController = vc
//        }
//    }
	
    @IBAction func login(sender: AnyObject) {
        
        
//        timer2 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(LoginViewController.updateTime2), userInfo: nil, repeats: true)
//        audioPlayer.stop()
//        audioPlayer.setVolume(1, fadeDuration: 0)
//        audioPlayer.currentTime = 104.5
//        audioPlayer.play()
//        audioPlayer.setVolume(0, fadeDuration: 5.5)
 
        
//        let username = self.nameTextField.text
//        let password = self.passwordTextField.text
//        let name = "Cloud"
//        let storyboard = UIStoryboard(name: name, bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: name) as! CloudTableViewController
//        vc.username = username!
//        vc.password = password!
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = vc

        let name = "Rating"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! UITabBarController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = vc
        
        
        
//        LoginService.sharedInstance.loginWithCompletionHandler(username, password: password) { (error) -> Void in
//            
//            if ((error) != nil) {
//                
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    var alert = UIAlertController(title: "Why are you doing this to me?!?", message: error, preferredStyle: .Alert)
//                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
//                    self.presentViewController(alert, animated: true, completion: nil)
//                })
//                
//            } else {
//                
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    let controllerId = LoginService.sharedInstance.isLoggedIn() ? "Welcome" : "Login";
//                    
//                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                    let initViewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier(controllerId) as UIViewController
//                    self.presentViewController(initViewController, animated: true, completion: nil)
//                })
//            }
//        }
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
