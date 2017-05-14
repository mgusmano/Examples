import UIKit

class MyTableViewCell: UITableViewCell {
	
	var myLabel1: UILabel!
	var myLabel2: UILabel!
	var myButton1 : UIButton!
	var myButton2 : UIButton!
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:)")
	}
	
	//override viewDidLayoutSubviews

	//MARK: Properties
	let colorDictionary = [
		"Red":UIColor(
			red: 1.0,
			green: 0.0,
			blue: 0.0,
			alpha: 1.0),
		"Green":UIColor(
			red: 0.0,
			green: 1.0,
			blue: 0.0, alpha: 1.0),
		"Blue":UIColor(
			red: 0.0,
			green: 0.0,
			blue: 1.0,
			alpha: 1.0),
		]
	
	//MARK: Instance methods
	func colorButton(withColor color:UIColor, title:String) -> UIButton {
		let newButton = UIButton(type: .system)
		newButton.backgroundColor = color
		newButton.setTitle(
			title,
			for: .normal)
		newButton.setTitleColor(
			UIColor.white,
			for: .normal)
		return newButton
	}
	
	func displayKeyboard() -> [UIButton] {
		//generate an array of buttons
		var buttonArray = [UIButton]()
		for (myKey,myValue) in colorDictionary{
			buttonArray += [colorButton(
				withColor: myValue,
				title: myKey)
			]
		}
		return buttonArray
	}
	
	func one() {
		let buttonArray = displayKeyboard()

		//Iteration two - nested stack views
		//set up the stack view
		let subStackView = UIStackView(arrangedSubviews: buttonArray)
		subStackView.axis = .horizontal
		subStackView.distribution = .fillEqually
		subStackView.alignment = .fill
		subStackView.spacing = 5
		//set up a label
		let label = UILabel()
		label.text = "Color Chooser"
		label.textColor = UIColor.white
		label.backgroundColor = UIColor.black
		label.textAlignment = .center
		
		let blackButton = colorButton(withColor: UIColor.black, title: "Black")
		
		let stackView = UIStackView(arrangedSubviews: [label,subStackView,blackButton])
		stackView.axis = .vertical
		stackView.distribution = .fillEqually
		stackView.alignment = .fill
		stackView.spacing = 10
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		contentView.addSubview(stackView)
		
		//autolayout the stack view - pin 30 up 20 left 20 right 30 down
		let viewsDictionary = ["stackView":stackView]
		let stackView_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[stackView]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
		let stackView_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[stackView]-30-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: viewsDictionary)
		contentView.addConstraints(stackView_H)
		contentView.addConstraints(stackView_V)
	}
	
	
	func two() {
		let buttonArray = displayKeyboard()
		
		let stackView = UIStackView(arrangedSubviews: buttonArray)
				stackView.axis = .horizontal
				stackView.distribution = .fillEqually
				stackView.alignment = .fill
				stackView.spacing = 0
				stackView.translatesAutoresizingMaskIntoConstraints = false
				contentView.addSubview(stackView)
		
		
				//autolayout the stack view - pin 30 up 20 left 20 right 30 down
				let viewsDictionary = ["stackView":stackView]
				let stackView_H = NSLayoutConstraint.constraints(
					withVisualFormat: "H:|-0-[stackView]-0-|",  //horizontal constraint 20 points from left and right side
					options: NSLayoutFormatOptions(rawValue: 0),
					metrics: nil,
					views: viewsDictionary)
				let stackView_V = NSLayoutConstraint.constraints(
					withVisualFormat: "V:|-0-[stackView]-0-|", //vertical constraint 30 points from top and bottom
					options: NSLayoutFormatOptions(rawValue:0),
					metrics: nil,
					views: viewsDictionary)
				contentView.addConstraints(stackView_H)
				contentView.addConstraints(stackView_V)
	}
	
	
	func three() {
		
//		let gap : CGFloat = 10
//		let labelHeight: CGFloat = 30
//		let labelWidth: CGFloat = 150
//		let lineGap : CGFloat = 5
//		let label2Y : CGFloat = gap + labelHeight + lineGap
//		let imageSize : CGFloat = 30
		
		myLabel1 = UILabel()
		//myLabel1.frame = CGRect(x:gap, y:gap, width:labelWidth, height:labelHeight)
		myLabel1.textColor = UIColor.black
		//myLabel1.font = UIFont(name: myLabel1.font.fontName, size: 14)
		
		//myLabel1.font = UIFont(name: "Avenir-Light", size: 15.0)
		myLabel1.font = UIFont(name: "Zapfino", size: 15.0)
		//myLabel1.font = UIFont.boldSystemFont(ofSize: 15)
		//myLabel1.font = UIFont.italicSystemFont(ofSize: 15)
		//myLabel1.font = UIFont.systemFont(ofSize: 17)
		
		
		contentView.addSubview(myLabel1)
		
		myLabel2 = UILabel()
		//myLabel2.frame = CGRect(x:gap, y:label2Y, width:labelWidth, height:labelHeight)
		myLabel2.textColor = UIColor.black
		contentView.addSubview(myLabel2)
		
		myButton1 = UIButton()
		//myButton1.frame = CGRect(x:bounds.width-imageSize - gap, y:gap, width:imageSize, height:imageSize)
		myButton1.setImage(UIImage(named: "candy"), for: UIControlState.normal)
		//contentView.addSubview(myButton1)
		
		myButton2 = UIButton()
		//myButton2.frame = CGRect(x:bounds.width-imageSize - gap, y:label2Y, width:imageSize, height:imageSize)
		myButton2.setImage(UIImage(named: "ice"), for: UIControlState.normal)
		//contentView.addSubview(myButton2)
		
		myLabel1.translatesAutoresizingMaskIntoConstraints = false
		myLabel2.translatesAutoresizingMaskIntoConstraints = false
		//myButton1.translatesAutoresizingMaskIntoConstraints = false
		//myButton2.translatesAutoresizingMaskIntoConstraints = false
		
		
		let viewsDict = [
			"myLabel1" : myLabel1,
			"myLabel2" : myLabel2,
			"myButton1" : myButton1,
			"myButton2" : myButton2,
			] as [String : Any]
		
		contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[myLabel1]", options: [], metrics: nil, views: viewsDict))
		contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[myLabel2]", options: [], metrics: nil, views: viewsDict))
		//contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[myButton2(30)]-[myButton1]-|", options: [], metrics: nil, views: viewsDict))
		contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[myLabel1]-[myLabel2]-|", options: [], metrics: nil, views: viewsDict))
		//contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[myButton2]-[myButton1]-|", options: [], metrics: nil, views: viewsDict))
		
		
	}
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) { super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		myLabel1 = UILabel()
		myLabel2 = UILabel()
		myButton1 = UIButton()
		myButton2 = UIButton()
		
		one()
		//two()
		//three()
	}

}
