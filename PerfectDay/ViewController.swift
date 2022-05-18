//
//  ViewController.swift
//  PerfectDay
//
//  Created by comsoft on 2022/05/02.
//

import UIKit
import FSCalendar
import RealmSwift

class ViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {

    @IBOutlet weak var calendar : FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var todayLabel: UILabel!
    
    
    let identifier = "calendarCell"
    let dateFormatter = DateFormatter()
    let realm = try! Realm()
    
    var selectedDay = ""
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.calendar.dataSource = self
        self.calendar.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        calendarSetting()
        daySetting()
        print(realm.configuration.fileURL!)
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CalendarTableViewCell
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension ViewController {
    
    func calendarSetting() {
        calendar.appearance.selectionColor = UIColor(red: 38/255, green: 153/255, blue: 251/255, alpha: 1)
        calendar.appearance.todayColor = UIColor(red: 188/255, green: 224/255, blue: 253/255, alpha: 1)
        calendar.scrollDirection = .vertical
        calendar.appearance.titleWeekendColor = .red
        calendar.appearance.headerDateFormat = "YYYY년 M월"
    }
    func daySetting() {
        dateFormatter.dateFormat = "YY년 MM월 dd일"
        let today = dateFormatter.string(from: Date())
        todayLabel.text = today
    }
    
    public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY년 MM월 dd일"
        todayLabel.text = dateFormatter.string(from: date)
        selectedDay = dateFormatter.string(from: date)
        tableView.reloadData()
        
    }
    
}

class ScheduleByDate: Object {
    @objc dynamic var date: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var time: String = ""
    @objc dynamic var success: Bool = false
}

class ScheduleList : Object {
    var scheduleList = List<ScheduleByDate>()
}
