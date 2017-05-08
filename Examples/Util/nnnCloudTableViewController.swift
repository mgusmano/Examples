import UIKit



class CloudTableViewController: UITableViewController {

    var username = String()
    var password = String()
    
    @IBAction func goBack(_ sender: Any) {
       Util.nav("Menu")
    }
    
    //var TableData:Array<String> = ["1","2"]
    //return TableData.count
    //cell.textLabel?.text = TableData[indexPath.row]
    
    var TableData:Array<String> = Array <String>()

    
    @IBAction func ButtonClick(_ sender: UIButton){
        print("Button tapped")
    }
    
    var roundButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
   
        roundButton = UIButton(type: .custom)
        roundButton.setTitleColor(UIColor.orange, for: .normal)
        roundButton.addTarget(self, action: #selector(ButtonClick(_:)), for: UIControlEvents.touchUpInside)
        view.addSubview(roundButton)
        
        
        
        print(self.username)
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
      
 
        let name = "mgusmano-yahoo-com-s-your--g8e"
        let password = "a3bbba239cefe97f93acbc909dfb1c9b"
        let url = "https://cloud.estimote.com/v2/devices/"
       
        makeGetCall(name, password, url)
    }
    
    override func viewWillLayoutSubviews() {
        
        roundButton.layer.cornerRadius = roundButton.layer.frame.size.width/2
        roundButton.backgroundColor = UIColor.lightGray
        roundButton.clipsToBounds = true
        roundButton.setImage(UIImage(named:"your-image"), for: .normal)
        roundButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            roundButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -3),
            roundButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -53),
            roundButton.widthAnchor.constraint(equalToConstant: 50),
            roundButton.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    
    
    
    func makeGetCall(_ name: String, _ password: String, _ url: String) {
        //let lemon = "f4d5260f34dd516c99f281e06c885402"
        //let devicesEndpoint2: String = "https://cloud.estimote.com/v2/devices/" + lemon
        //let devicesEndpoint: String = "https://cloud.estimote.com/v2/devices/"
        let devicesEndpoint: String = url
        guard let url = URL(string: devicesEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let basic = name + ":" + password
        let data = (basic).data(using: String.Encoding.utf8)
        let base64 = data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        let headers = [
            "Authorization": "Basic " + base64,
            "Accept": "application/json"
        ]
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = headers
        let session = URLSession(configuration: config)

        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data: Data?, response: URLResponse?, error: Error?) in
            guard error == nil else {
                print("error calling GET on /devices")
                print(error!)
                return
            }
            self.extract_json(data!)
            return
        })
        task.resume()
    }
    
    func extract_json(_ data: Data)
    {
        let json: Any?
        do {
            json = try JSONSerialization.jsonObject(with: data, options: [])
        }
        catch {
            return
        }
        guard let data_list = json as? NSArray else {
            return
        }
        
        if let devices_list = json as? NSArray
        {
            for i in 0 ..< data_list.count
            {
                if let device_obj = devices_list[i] as? NSDictionary
                {
                    if let device_identifier = device_obj["identifier"] as? String
                    {
                        if let device_color = device_obj["color"] as? String
                        {
                            TableData.append(device_identifier + " [" + device_color + "]")
                        }
                        
                    }
                }
            }
        }
        DispatchQueue.main.async(execute: {self.do_table_refresh()})
    }
    
    func do_table_refresh() {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = TableData[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        print("section: \(indexPath.section)")
        print("row: \(indexPath.row)")
        
        
        
        
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        print("Row: \(row)")
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // 1. set the initial state of the cell
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform = transform
        
        // 2. UIView animation method to change to the final state of the cell
        UIView.animate(withDuration: 0.5, animations: {
            cell.alpha = 1.0
            cell.layer.transform = CATransform3DIdentity
        })
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
