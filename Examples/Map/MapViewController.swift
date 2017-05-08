import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
	
	@IBAction func Menu(_ sender: Any) { Util.nav("Menu") }
	
	var locationManager:CLLocationManager!
	var mapView:MKMapView = MKMapView()
	
//	override func viewDidLoad() {
//		super.viewDidLoad()
//		// Do any additional setup after loading the view, typically from a nib.
//	}
//		
//	override func didReceiveMemoryWarning() {
//		super.didReceiveMemoryWarning()
//		// Dispose of any resources that can be recreated.
//	}
		
	override func viewWillAppear(_ animated: Bool) {
			super.viewWillAppear(animated)
			
			let screenSize: CGRect = UIScreen.main.bounds
			let screenWidth = screenSize.width
			let screenHeight = screenSize.height
			
			mapView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight);
			
			determineMyCurrentLocation()
			
//			let leftMargin:CGFloat = 10
//			let topMargin:CGFloat = 60
//			let mapWidth:CGFloat = view.frame.size.width-20
//			let mapHeight:CGFloat = 300
//			
//			mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
			
			mapView.mapType = MKMapType.standard
			mapView.isZoomEnabled = true
			mapView.isScrollEnabled = true
			
			// Or, if needed, we can position map in the center of the view
			mapView.center = view.center
			
			view.addSubview(mapView)
	}
	
	func determineMyCurrentLocation() {
		locationManager = CLLocationManager()
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestAlwaysAuthorization()
		
		if CLLocationManager.locationServicesEnabled() {
			locationManager.startUpdatingLocation()
			//locationManager.startUpdatingHeading()
		}
		mapView.mapType = MKMapType.satellite
		mapView.showsUserLocation = true
		mapView.showsTraffic = true
		mapView.showsBuildings = true
		mapView.showsScale = true
		mapView.showsCompass = true
		
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let location:CLLocation = locations[0] as CLLocation
		
		// Call stopUpdatingLocation() to stop listening for location updates,
		// other wise this function will be called every time when user location changes.
		
		manager.stopUpdatingLocation()
		
		let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
		let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
		
		mapView.setRegion(region, animated: true)
		
		print("user latitude = \(location.coordinate.latitude)")
		print("user longitude = \(location.coordinate.longitude)")
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
	{
		print("Error \(error)")
	}
	
}
