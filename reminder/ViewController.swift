import UIKit
import UserNotifications

class ViewController: UIViewController {

    var models = [reminder]()
    let table = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(table)
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
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { success, error in
            if(success){
                self.scheduleTest()
            }else if let error = error{
                print(error)
            }
        }
    }
    
    func scheduleTest(){
        let content = UNMutableNotificationContent()
        content.title = "creating first notification"
        content.badge = 100
        content.body = "long text is written here please help me read it it's too large to read.!!"
        content.sound = .default
        let date = Date().addingTimeInterval(5)
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
        guard let vc = storyboard?.instantiateViewController(identifier: "enterTask") else { return  }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = "shashwat"
        cell.detailTextLabel?.text = "shruti"
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
