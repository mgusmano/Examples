struct Menu {
	let title: String
	let storyboard: String
}

extension Menu {
	init(json: [String: AnyObject]) throws {
		guard let title = json["title"] as? String else {throw JSONError.missing("title")}
		guard let storyboard = json["storyboard"] as? String else {throw JSONError.missing("storyboard")}
		self.title = title
		self.storyboard = storyboard
	}
}
