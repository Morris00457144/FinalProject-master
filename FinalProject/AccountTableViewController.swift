//
//  AccountTableViewController.swift
//  FinalProject
//
//  Created by User04 on 2018/6/22.
//  Copyright © 2018年 User04. All rights reserved.
//

import UIKit

class AccountTableViewController: UITableViewController {

    var accounts = [Account]()
    
    @IBAction func goBackToAccountTable(segue: UIStoryboardSegue){
        let controller = segue.source as? EditAccountTableViewController
        
        if let account = controller?.account{
            if let row = tableView.indexPathForSelectedRow?.row{
                accounts[row] = account
            }else{
                accounts.insert(account, at: 0)
            }
            Account.saveToFile(accounts: accounts)
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "IMG_7517"))
        self.tableView.backgroundView?.alpha = 0.3
        navigationController?.navigationBar.tintColor = UIColor.white;
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        if let accounts = Account.readAccountsFromFile(){
            self.accounts = accounts
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return accounts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "accountCell", for: indexPath) as! AccountTableViewCell
        
        let account = accounts[indexPath.row]
        cell.itemLabel.text = account.item
        cell.moneyLabel.text = account.money
        cell.timeLabel.text = account.time

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        accounts.remove(at: indexPath.row)
        Account.saveToFile(accounts: accounts)
        tableView.reloadData()
        
    }
    

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
        
        if let row = tableView.indexPathForSelectedRow?.row{
            let account = accounts[row]
            let controller = segue.destination as? EditAccountTableViewController
            controller?.account = account
        }
    }
 

}
