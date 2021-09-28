import UIKit
import UserNotifications

class ViewController: UIViewController {

    var models = [reminder]()
    let table = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(table)
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { success, error in
            if(success){
               print("success")
            }else if let error = error{
                print(error)
            }
        }
        
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(didTapAddButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(didTapTestButton))
        navigationItem.title = "Reminder"
    }
    
    @objc func didTapTestButton(){
        print("play button tapped")
        
    }
    
    func scheduleTest(title:String,body:String,date:Date){
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.badge = 100
        content.body = body
        content.sound = .default
        let date = date
        let trigger =  UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.hour,.year,.second,.day,.minute,.month],
                                                                                                   from: date),
                                                     repeats: false)
        let request = UNNotificationRequest(identifier: "some_id", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request,withCompletionHandler:  { error in
            if error == nil{
                print("went ")
            }else{
                print("error")
            }
            
        })
    }
    @objc func didTapAddButton(){
        print("add button tapped")
        guard let vc = storyboard?.instantiateViewController(identifier: "enterTask") as? enterTaskViewController else { return  }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { title,description,Date in
            DispatchQueue.main.async {
                vc.navigationController?.popViewController(animated: true)
                let r = reminder(title: title, description: description, date: Date, identifier: "id_\(title)")
                self.models.append(r)
                self.table.reloadData()
                self.scheduleTest(title: title, body: description, date: Date)
            }
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = models[indexPath.row].title
        cell.detailTextLabel?.text = models[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
    }
}

struct reminder {
    var title:String
    var description:String
    var date:Date
    var identifier:String
}
