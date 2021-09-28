//
//  enterTaskViewController.swift
//  reminder
//
//  Created by Shashwat on 28/09/21.
//

import UIKit

class enterTaskViewController: UIViewController {
    
    
    var textField:UITextField = {
        let text = UITextField()
        text.placeholder = "New Task Title"
        text.borderStyle = .roundedRect
        text.backgroundColor = .systemGray6
        return text
    }()
    
    var desc:UITextField = {
        let des = UITextField()
        des.placeholder = "Description"
        des.borderStyle = .roundedRect
        des.backgroundColor = .systemGray6
        return des
    }()
    
    var date = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textField)
        view.addSubview(desc)
        view.addSubview(date)
        title = "New Reminder"
        date.preferredDatePickerStyle = .wheels
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTask))
    }
    
    @objc func saveTask(){
        guard let title = self.textField.text else{
            return
        }
        let des = self.desc.text!
        let date = self.date.date
        //let time  = self.date.timeZone
        print(title, des, date)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textField.frame = CGRect(x: 5, y: 200, width: view.frame.size.width - 10 , height: 50)
        desc.frame = CGRect(x: 5, y: textField.frame.maxY + 20, width: textField.frame.size.width, height: 50)
        date.frame = CGRect(x: 5, y: desc.frame.maxY + 20, width: textField.frame.size.width, height: 150)
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
