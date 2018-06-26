//
//  CalendarViewController.swift
//  FinalProject
//
//  Created by User04 on 2018/6/22.
//  Copyright © 2018年 User04. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    var currentYear = Calendar.current.component(.year, from: Date())
    var currentMonth = Calendar.current.component(.month, from: Date())
    var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var calendar: UICollectionView!
    @IBAction func nextMonth(_ sender: Any) {
        currentMonth += 1
        if currentMonth == 13{
            currentMonth = 1
            currentYear += 1
        }
        setUp()
    }

    @IBAction func lastMonth(_ sender: Any) {
        currentMonth -= 1
        if currentMonth == 0{
            currentMonth = 12
            currentYear -= 1
        }
        setUp()
    }
    
    var howManyItemsShouldIAdd:Int{
        return whatDayIsIt - 1
    }
    var whatDayIsIt:Int{
        let dateComponents = DateComponents(year: currentYear, month: currentMonth)
        let date = Calendar.current.date(from: dateComponents)!
        return Calendar.current.component(.weekday, from: date)
    }
    var numberOfDaysInThisMonth:Int{
        let dateComponents = DateComponents(year: currentYear, month: currentMonth)
        let date = Calendar.current.date(from: dateComponents)!
        let range = Calendar.current.range(of: .day, in: .month, for: date)
        return range?.count ?? 0
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white;
        // Do any additional setup after loading the view.
        
        setUp()
    }
    func setUp(){
        timeLabel.text = months[currentMonth - 1] + " \(currentYear)"
        calendar.reloadData()
        }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return numberOfDaysInThisMonth + howManyItemsShouldIAdd
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if let textLabel = cell.contentView.subviews[0] as? UILabel{
            if indexPath.row < howManyItemsShouldIAdd{
                textLabel.text = ""
            }else{
                textLabel.text =
                "\(indexPath.row + 1 - howManyItemsShouldIAdd)"
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        return CGSize(width: width, height: 40)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calendar.collectionViewLayout.invalidateLayout()
        calendar.reloadData()
    }
    private func collectionView(_ collectionView: UICollectionView,didSelectItemAtIndexPath indexPath: NSIndexPath){
        print("You select \(indexPath.section + 1) item")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
