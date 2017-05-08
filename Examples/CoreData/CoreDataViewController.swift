// https://www.raywenderlich.com/145809/getting-started-core-data-tutorial
import UIKit
import CoreData

// MARK: - UITableViewDataSource
extension CoreDataViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return users.count
	}
 
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let user = users[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text = user.value(forKeyPath: "name") as? String
		return cell
	}
}

class CoreDataViewController: UIViewController {
	var users: [NSManagedObject] = []
	
	@IBOutlet weak var tableView: UITableView!
	@IBAction func Menu(_ sender: UIBarButtonItem) { Util.nav("Menu") }

	override func viewDidLoad() {
		super.viewDidLoad()
		title = "The List"
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		let managedContext = persistentContainer.viewContext
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
		do {
			users = try managedContext.fetch(fetchRequest)
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
		}
	}
	
	@IBAction func addName(_ sender: Any) {
		let alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .alert)
		let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
			guard let textField = alert.textFields?.first,
			let nameToSave = textField.text else {
				return
			}
			self.save(name: nameToSave)
			self.tableView.reloadData()
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .default)
		alert.addTextField()
		alert.addAction(saveAction)
		alert.addAction(cancelAction)
		present(alert, animated: true)
	}
	
	func save(name: String) {
		let managedContext = persistentContainer.viewContext
		let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
		let user = NSManagedObject(entity: entity, insertInto: managedContext)
		user.setValue(name, forKeyPath: "name")
		do {
			try managedContext.save()
			users.append(user)
		} catch let error as NSError {
			print("Could not save. \(error), \(error.userInfo)")
		}
	}
	
	// MARK: - Core Data stack
	var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "CodeData")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()
	
	func saveContext() {
		let context = persistentContainer.viewContext
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}
}
