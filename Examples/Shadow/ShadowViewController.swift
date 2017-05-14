import UIKit
import FacebookCore
import FacebookLogin

class ShadowViewController: UIViewController, LoginButtonDelegate {

	func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
		print("a")
		switch result {
		case .failed(let error):
			print("1")
			print(error)
		case .cancelled:
			print("Cancelled")
		case .success(let grantedPermissions, let declinedPermissions, let accessToken):
			print("Logged In")
			facebookLogin()
		}
	}
	
	func loginButtonDidLogOut(_ loginButton: LoginButton) {
		print("Logged Out")
	}
	
	func facebookLogin() {
		if let accessToken = AccessToken.current {
			let params = ["fields":"name,email"]
			let graphRequest = GraphRequest(graphPath: "me", parameters: params)
			graphRequest.start { (urlResponse, requestResult) in
				switch requestResult {
				case .failed(let error):
					print(error)
				case .success(let graphResponse):
					if let responseDictionary = graphResponse.dictionaryValue {
						UserDefaults.standard.set(responseDictionary, forKey: "userInfo")
					}
				}
			}
		} else {
		}
	}
	
	
	
	@IBAction func Menu(_ sender: Any) { Util.nav("Menu") }
	@IBOutlet weak var img01: UIImageView!
	@IBOutlet weak var img02: UIImageView!
	@IBOutlet weak var img03: UIImageView!
	@IBOutlet weak var img04: UIImageView!
	@IBOutlet weak var img05: UIImageView!
	@IBOutlet weak var hotel: UIImageView!
	@IBOutlet weak var img06: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
		
	
		let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends ])
		loginButton.delegate = self
		loginButton.center = view.center
		
		view.addSubview(loginButton)
		
		
		
		let h2 = UIImageView(image: UIImage(named: "hotel01"))
		h2.frame = CGRect(x: 30, y: 140, width: 50, height: 25)
		
		h2.alpha = 0.5
		h2.contentMode = .scaleAspectFill

		view.addSubview(h2)
		
		
		
		hotel.alpha = 0.5
		hotel.contentMode = .scaleAspectFill
	
		
		
		img02.layer.zPosition = 1
		print(img01.layer.zPosition)
		print(img02.layer.zPosition)
		print(img03.layer.zPosition)
		print(img04.layer.zPosition)
		print(img05.layer.zPosition)
		print(img06.layer.zPosition)
		
		
		
		//https://www.innofied.com/implementing-shadow-ios/
		img01.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
		img01.layer.shadowOffset = CGSize(width:6.0, height:6.0)
		img01.layer.shadowOpacity = 1.0
		img01.layer.shadowRadius = 3.0

		img02.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
		img02.layer.shadowOffset = CGSize(width:0.0, height:0.0)
		img02.layer.shadowOpacity = 1.0
		img02.layer.shadowRadius = 6.0

		let size = img03.bounds.size
		let path = UIBezierPath()
		path.move(to: CGPoint(x: size.width * 0.20, y: size.height * 0.80))
		path.addLine(to: CGPoint(x: size.width * 0.80, y: size.height * 0.80))
		path.addLine(to: CGPoint(x: size.width * 1.20, y: size.height * 1.20))
		path.addLine(to: CGPoint(x: size.width * -0.20, y: size.height * 1.20))
		path.close()
		img03.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
		img03.layer.shadowOffset = CGSize(width:3.0, height:3.0)
		img03.layer.shadowOpacity = 1.0
		img03.layer.shadowRadius = 2.0
		img03.layer.shadowPath = path.cgPath
		
		let ovalRect = CGRect(x:0.0, y:img04.frame.size.height + 10, width:img04.frame.size.width, height:15)
		let path04 = UIBezierPath(ovalIn: ovalRect)
		img04.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
		img04.layer.shadowOffset = CGSize(width:0.0, height:0.0)
		img04.layer.shadowOpacity = 1.0
		img04.layer.shadowRadius = 3.0
		img04.layer.shadowPath = path04.cgPath
		
		let size05 = img05.frame.size
		let path05 = UIBezierPath()
		path05.move(to: CGPoint(x:0.0, y:size05.height))
		path05.addLine(to: CGPoint(x:0.0, y:size05.height + 20.0))
		path05.addCurve(to: CGPoint(x:size05.width, y:size05.height + 20.0), controlPoint1: CGPoint(x:20.0, y:size05.height), controlPoint2: CGPoint(x:size05.width - 20.0, y:size05.height))
		path05.addLine(to: CGPoint(x:size05.width, y:size05.height))
		path05.close()
		img05.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
		img05.layer.shadowOffset = CGSize(width:0.0, height:0.0);
		img05.layer.shadowOpacity = 1.0
		img05.layer.shadowRadius = 3.0
		img05.layer.shadowPath = path05.cgPath
		
		img06.layer.shadowColor =  UIColor(white: 0.0, alpha: 0.5).cgColor
		img06.layer.shadowOffset = CGSize(width:20.0, height:-20.0)
		img06.layer.shadowOpacity = 1.0
		img06.layer.shadowRadius = 2.0
		let animation = CABasicAnimation(keyPath: "shadowOffset")
		animation.fromValue = NSValue(cgSize:CGSize(width:-20.0, height:-20.0))
		animation.toValue = NSValue(cgSize: CGSize(width:20.0, height:-20.0))
		animation.duration = 2.0
		img06.layer.add(animation, forKey: "shadowOffset")
		
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
