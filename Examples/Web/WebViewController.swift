import UIKit

class WebViewController: UIViewController {

	@IBAction func Menu(_ sender: Any) { Util.nav("Menu") }
	@IBOutlet weak var webView: UIWebView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		var url:URL
		//url = URL(string: "http://www.estimote.com")!;
		url = Bundle.main.url(forResource: "index", withExtension: "html")!;
		webView.loadRequest(URLRequest(url: url as URL));
		
//		var htmlString:String
//		htmlString = "<br /><h2>Welcome as a String!!!</h2>"
//		webView.loadHTMLString(htmlString, baseURL: nil)
    }
	
//	
//
//	webView.goBack(); // uiwebview navigate back
// 
//	webView.goForward(); // uiwebview navigate forward
// 
//	webView.reload(); // to refresh the uiwebview
// 
//	webView.stopLoading(); // to stop the loading from uiwebview
	
//	let myWebView:UIWebView = UIWebView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
//	myWebView.loadRequest(NSURLRequest(URL: NSURL(string: "http://www.sourcefreeze.com")!))
//	self.view.addSubview(myWebView)
	
	
}
