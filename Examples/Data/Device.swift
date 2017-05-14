import UIKit

struct Device {
	let type: String
	let identifier: String
	let color: String
	let uuid: String
	let major: Int
	let minor: Int
	func iconImage() -> UIImage {
		return UIImage(named: self.color + ".png")!
	}
}

extension Device {
	init(json: [String: AnyObject]) throws {
		guard let type = json["type"] as? String else {throw JSONError.missing("type")}
		guard let identifier = json["identifier"] as? String else {throw JSONError.missing("identifier")}
		guard let color = json["color"] as? String else {throw JSONError.missing("color")}
		
		let settings = json["settings"] as! NSDictionary
		let advertisers = settings["advertisers"] as! NSDictionary
		let ibeacons = advertisers["ibeacon"] as! NSArray
		let ibeacon = ibeacons[0] as! NSDictionary
		
		guard let uuid = ibeacon["uuid"] as? String else {throw JSONError.missing("uuid")}
		guard let major = ibeacon["major"] as? Int else {throw JSONError.missing("major")}
		guard let minor = ibeacon["minor"] as? Int else {throw JSONError.missing("minor")}
		
		self.type = type
		self.identifier = identifier
		self.color = color
		self.uuid = uuid
		self.major = major
		self.minor = minor
	}
}

extension Device {
	static func getDevices(completion: @escaping ([Device]) -> Void) {
		let url = "https://cloud.estimote.com/v2/devices/"
		let withURL = URLRequest(url: URL(string: url)!)
		let session = Util.getEstimoteSession()
		session.dataTask(with: withURL, completionHandler: {
			(data: Data?, response: URLResponse?, error: Error?) in
			var devices: [Device] = []
			if let data = data,
				let json = try? JSONSerialization.jsonObject(with: data, options: []) {
				guard let jsonArray = json as? NSArray else {return}
				for case let result in jsonArray {
					if let device = try? Device(json: result as! [String : AnyObject]) {
						devices.append(device)
					}
				}
			}
			completion(devices)
		}).resume()
	}
}
