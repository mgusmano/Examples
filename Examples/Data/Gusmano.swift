import Foundation
import UIKit

struct Gusmano {
	let id: String
	let email: String
	let firstname: String
	let lastname: String
	let title: String
	let phone: String
	let picture: String
}

extension Gusmano {
	init(json: [String: AnyObject]) throws {
		guard let id = json["id"] as? String else {throw MyDataError.missing("id")}
		guard let email = json["email"] as? String else {throw MyDataError.missing("email")}
		guard let firstname = json["firstname"] as? String else {throw MyDataError.missing("firstname")}
		guard let lastname = json["lastname"] as? String else {throw MyDataError.missing("lastname")}
		guard let title = json["title"] as? String else {throw MyDataError.missing("title")}
		guard let phone = json["phone"] as? String else {throw MyDataError.missing("phone")}
		guard let picture = json["picture"] as? String else {throw MyDataError.missing("picture")}
		self.id = id
		self.email = email
		self.firstname = firstname
		self.lastname = lastname
		self.title = title
		self.phone = phone
		self.picture = picture
	}
}

extension Gusmano {
	static func getGusmanos(completion: @escaping ([Gusmano]) -> Void) {
		let url = "http://mjg-expressapp.azurewebsites.net/People"
		let withURL = URLRequest(url: URL(string: url)!)
		let session = Util.getEstimoteSession()
		session.dataTask(with: withURL, completionHandler: {
			(data: Data?, response: URLResponse?, error: Error?) in
			var gusmanos: [Gusmano] = []
			if let data = data,
				let json = try? JSONSerialization.jsonObject(with: data, options: []) {
				guard let jsonArray = json as? NSArray else {return}
				for case let result in jsonArray {
					if let gusmano = try? Gusmano(json: result as! [String : AnyObject]) {
						gusmanos.append(gusmano)
					}
				}
			}
			completion(gusmanos)
		}).resume()
	}
}

