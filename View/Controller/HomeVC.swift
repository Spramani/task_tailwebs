//
//  HomeVC.swift
//  task_Tailwebs
//
//  Created by Shubham Ramani on 15/03/24.
//

import UIKit


class HomeVC: UIViewController,UIScrollViewDelegate {
    
    lazy var tableData:[data] = [data]()
    lazy var filterData:[data] = [data]()
    
    var selected_date_index = 0
    
    //custom date
    let calendar = Calendar.current
    var date = Date()
    var days = 0
    var extra_beginning_days = 0
    var dates = [NSDictionary]()
    var selected_day = String()
    var selected_days:[String] = [String]()
    
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableContainerView: UIView!
    
    @IBOutlet weak var col_calender: UICollectionView!
    @IBOutlet weak var con_calender_height: NSLayoutConstraint!
    @IBOutlet weak var lbl_month: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        }
    }
    
    @IBOutlet weak var shadowView: UIView!{
        didSet{
            shadowView.layer.cornerRadius = 10
            shadowView.layer.masksToBounds = false
            
            shadowView.layer.shadowColor = UIColor.black.cgColor
            shadowView.layer.shadowOpacity = 0.5
            shadowView.layer.shadowOffset = CGSize(width: 0, height: 2) // Adjust the vertical offset as needed
            shadowView.layer.shadowRadius = 3
            
        }
    }
    @IBOutlet weak var amountView: UIView!{
        didSet{
            amountView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
            amountView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var hoursView: UIView!{
        didSet{
            hoursView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
            hoursView.layer.cornerRadius = 10
        }
    }
  
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        self.selected_day = Date().getDateString()
        self.getCalenderData()
        collectionSetup()
        
        tableView.isScrollEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableData = [data(date: "10/03/2024",totalTime: "10h 14 min", time: "12:30PM - 2:30AM", amount: "$95.00"),
                     data(date: "11/03/2024",totalTime: "10h 14 min", time: "12:30PM - 2:30AM", amount: "$95.00"),
                     data(date: "12/04/2024",totalTime: "10h 14 min", time: "12:30PM - 2:30AM", amount: "$95.00"),
                     data(date: "13/04/2024",totalTime: "10h 14 min", time: "12:30PM - 2:30AM", amount: "$95.00"),
                     data(date: "11/03/2024",totalTime: "10h 14 min", time: "12:30PM - 2:30AM", amount: "$95.00"),
                     data(date: "10/03/2024",totalTime: "10h 14 min", time: "12:30PM - 2:30AM", amount: "$95.00"),
                     data(date: "21/03/2024",totalTime: "10h 14 min", time: "12:30PM - 2:30AM", amount: "$95.00"),
                     data(date: "22/03/2024",totalTime: "10h 14 min", time: "12:30PM - 2:30AM", amount: "$95.00"),
                     data(date: "23/05/2024",totalTime: "10h 14 min", time: "12:30PM - 2:30AM", amount: "$95.00"),
                     data(date: "25/05/2024",totalTime: "10h 14 min", time: "12:30PM - 2:30AM", amount: "$95.00"),
                     data(date: "24/03/2024",totalTime: "10h 14 min", time: "12:30PM - 2:30AM", amount: "$95.00"),
                     data(date: "25/03/2024",totalTime: "10h 14 min", time: "12:30PM - 2:30AM", amount: "$95.00"),
                     data(date: "01/03/2024",totalTime: "10h 14 min", time: "12:30PM - 2:30AM", amount: "$95.00"),
                     data(date: "02/03/2024",totalTime: "10h 14 min", time: "12:30PM - 2:30AM", amount: "$95.00"),
                     data(date: "02/03/2024",totalTime: "10h 14 min", time: "12:30PM - 2:30AM", amount: "$95.00"),
                     data(date: "03/04/2024",totalTime: "10h 14 min", time: "12:30PM - 2:30AM", amount: "$95.00"),
                     data(date: "04/04/2024",totalTime: "10h 14 min", time: "12:30PM - 2:30AM", amount: "$95.00"),
                     data(date: "07/03/2024",totalTime: "10h 14 min", time: "12:30PM - 2:30AM", amount: "$95.00")]
    
        tableData.filter { data in
            if data.date.stringToDate().month() == date.month(){
                filterData.append(data)
            }
            return true
        }
        // Do any additional setup after loading the view.
        tableView.reloadData()
        scrollView.delegate = self
        
    }
    
    func getCalenderData(){
        // Calculate start and end of the current year (or month with `.month`):
        let interval = calendar.dateInterval(of: .month, for: date)
        extra_beginning_days = calendar.component(.weekday, from: date.startOfMonth()) - 1
        
        // Compute difference in days:
        days = (calendar.dateComponents([.day], from: interval?.start ?? Date(), to: interval?.end ?? Date()).day ?? 0) + extra_beginning_days
        
        let width = col_calender.bounds.width / 9
        con_calender_height.constant = CGFloat(width * Double(((days % 7) == 0 ? (days / 7) : (days / 7) + 1)))
        col_calender.reloadData()
        
        lbl_month.text = "\(date.month()) \(date.year())"
        filterData.removeAll()
        
        let _ = tableData.filter { data in
            if selected_days.count > 0 {
                
                if selected_days.contains(where: {$0.stringToDate().month() == date.month()}) {
                    if data.date.stringToDate().month() == date.month(){
                        if selected_days.contains(where: {$0.stringToDate().day() == data.date.stringToDate().day()}){
                            filterData.append(data)
                        }
                    }
                    let data = filterData.sorted(by: {$0.date.stringToDate().compare($1.date.stringToDate()) == .orderedAscending})
                    filterData.removeAll()
                    filterData = data
                }else{
                    getMonthData()
                }
            }else{
                getMonthData()
            }
            return true
        }
        tableView.reloadData()
        
    }
    
    func getMonthData(){
        filterData.removeAll()
        let _ = tableData.filter { data in
            if data.date.stringToDate().month() == date.month(){
                filterData.append(data)
            }
            return true
        }
        let data = filterData.sorted(by: {$0.date.stringToDate().compare($1.date.stringToDate()) == .orderedAscending})
        filterData.removeAll()
        filterData = data
        tableView.reloadData()
    }
    
    
    @IBAction func BTNPreviousMonthAction(_ sender: UIButton) {
        date = calendar.date(byAdding: .month, value: -1, to: date) ?? Date()
        self.getCalenderData()
    }
    
    @IBAction func BTNNextMonthAction(_ sender: UIButton) {
        date = calendar.date(byAdding: .month, value: 1, to: date) ?? Date()
        self.getCalenderData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let top = self.tableContainerView.frame.minY
        
        if top <= currentOffset{
            self.tableView.isScrollEnabled = true
        }else if scrollView == tableView, currentOffset == 0{
            self.tableView.isScrollEnabled = false
        }
    }

}

//MARK: - Collection setup
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionSetup(){
        col_calender.delegate = self
        col_calender.dataSource = self
        col_calender.register(UINib(nibName: "CalenderDateCVC", bundle: nil), forCellWithReuseIdentifier: "CalenderDateCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = col_calender.dequeueReusableCell(withReuseIdentifier: "CalenderDateCVC", for: indexPath) as! CalenderDateCVC
        
        let ind = indexPath.row - extra_beginning_days
        let day = ind + 1
        let attributed_text = NSAttributedString(
            string: "\(day)",
            attributes: [:]
        )
        cell.lbl_date.attributedText = attributed_text //"\(day > 0 ? day : 0)" == "0" ? EMPTY : "\(day)"
        
        if ind >= 0{
            let date_formatter = DateFormatter()
            date_formatter.dateFormat = "dd/MM/yyyy"
   
            let days = selected_days.map { str in
                date_formatter.date(from: str)
            }
            cell.lbl_date.backgroundColor = .clear
            cell.lbl_date.textColor = .white
            
            for i in days {
                if day == Int(i?.day() ?? ""), date.month_numeric() == i?.month_numeric() ?? ""{
                    cell.lbl_date.backgroundColor = UIColor(named: "selectedColor")
                    cell.lbl_date.textColor = .white
                }
            }
        }else{
            cell.lbl_date.backgroundColor = .clear
            cell.lbl_date.textColor = .clear
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: col_calender.bounds.width/7, height: col_calender.bounds.width/9)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ind = indexPath.row - extra_beginning_days
        let day = ind + 1
        
        if ind >= 0{
            let df = DateFormatter()
            df.dateFormat = "dd/MM/yyyy"
            let selected = df.date(from: "\(day > 9 ? "\(day)" : "0\(day)")/\(date.month())/\(date.year())")
            selected_day = selected?.getDateString() ?? ""
            if selected_days.contains(where: {$0 == selected?.getDateString() ?? ""}){
                guard let ind = selected_days.firstIndex(where: {$0 == selected?.getDateString() ?? ""}) else { return }
                selected_days.remove(at: ind)
            }else{
                
                selected_days.append(selected?.getDateString() ?? "")
            }
            
            selectedData()
            
            col_calender.reloadData()
            
        }
    }
    
    func selectedData(){
        filterData.removeAll()
        if selected_days.count > 0 {
            if selected_days.contains(where: {$0.stringToDate().month() == date.month()}) {
                for i in tableData {
                    if i.date.stringToDate().month() == date.month(){
                        if selected_days.contains(where: {$0.stringToDate().day() == i.date.stringToDate().day()}){
                            filterData.append(i)
                        }
                    }
                }
                let data = filterData.sorted(by: {$0.date.stringToDate().compare($1.date.stringToDate()) == .orderedAscending})
                filterData.removeAll()
                filterData = data
            }else{
                getMonthData()
            }
        }else{
            getMonthData()
        }
        tableView.reloadData()
    }
}


//MARK:- Tableview Setup
extension HomeVC:UITableViewDataSource, UITableViewDelegate {
    
    
    // MARK: - Table view data source
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let date = filterData[indexPath.row].date.stringToDate()
        
        
        cell.setupData(date: date.day() , day: date.month() , cellData: filterData[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
            })
    }
}




