//
//  EditAccountTableViewController.swift
//  FinalProject
//
//  Created by User04 on 2018/6/22.
//  Copyright © 2018年 User04. All rights reserved.
//

import UIKit

class EditAccountTableViewController: UITableViewController ,UITextFieldDelegate{

    var account: Account?
    var datePicker : UIDatePicker!
    
    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
   
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EditAccountTableViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "IMG_7514"))
        self.tableView.backgroundView?.alpha = 0.3
        navigationController?.navigationBar.tintColor = UIColor.white;
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        if let account = account{
            itemTextField.text = account.item
            moneyTextField.text = account.money
            timeTextField.text = account.time
        }
    }
    
    
    @IBAction func doneButtonPressed(_ sender: Any) {
            if itemTextField.text?.count == 0{
                let alertController = UIAlertController(title: "請輸入商品名稱", message: nil, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(action)
                present(alertController, animated: true, completion: nil)
                return
            }
            if moneyTextField.text?.count == 0{
                let alertController = UIAlertController(title: "請輸入金額", message: nil, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(action)
                present(alertController, animated: true, completion: nil)
                return
            }
            if timeTextField.text?.count == 0{
                let alertController = UIAlertController(title: "請輸入日期", message: nil, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(action)
                present(alertController, animated: true, completion: nil)
                return
            }
            performSegue(withIdentifier: "goBackToAccountTableWithSegue", sender: nil)
        }
    
    @IBAction func EditTime(_ sender: UITextField) {
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y:0,width: self.view.frame.size.width, height:216))
        self.datePicker.datePickerMode = .date
        //datePicker.minuteInterval = 15
        datePicker.date = NSDate() as Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateFormat = "yyyy-M-d"
        let fromDateTime = dateFormatter.date(from: "2018-06-25 12:00")
        datePicker.minimumDate = fromDateTime
        datePicker.locale = NSLocale(localeIdentifier: "zh_TW") as Locale
        
        
        timeTextField.inputView = datePicker
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title:"Done", style: .plain, target: self ,action: #selector(self.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        
        toolBar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        timeTextField.inputAccessoryView = toolBar
    }
    @objc func doneClick(){
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        dateFormatter1.dateFormat = "yyyy-M-d"
        timeTextField.text = dateFormatter1.string(for : datePicker.date)
        timeTextField.resignFirstResponder()
    }
    @objc func cancelClick(){
        timeTextField.resignFirstResponder()
    }
    func datePickerValueChanged(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "MMMM dd yyyy"
        timeTextField.text = dateFormatter.string(from: sender.date)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
   

    // MARK: - Table view data source

   

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if account == nil{
            account = Account(item: itemTextField.text!, money: moneyTextField.text!,time: timeTextField.text!)
        }else{
            account?.item = itemTextField.text!
            account?.money = moneyTextField.text!
            account?.time = timeTextField.text!
        }
        
    }
    

}
