//
//  JournalViewController.swift
//  Journal
//
//  Created by 王珈玮 on 2022/5/5.
//

class EntryCell: UITableViewCell {
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var entryTextLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
}

import UIKit

class JournalViewController: UITableViewController {
    
    var entries: [Entry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let context = (UIApplication.shared.delegate as?
                          AppDelegate)?.persistentContainer.viewContext{
            
            if let entriesFromCoreDate = try? context.fetch(Entry.fetchRequest()) {
                entries = entriesFromCoreDate
                tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell") as? EntryCell else {
            return UITableViewCell()
        }
        let entry = entries[indexPath.row]
        cell.entryTextLabel.text = entry.text
        cell.monthLabel.text = entry.month()
        cell.dayLabel.text = entry.day()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry = entries[indexPath.row]
        performSegue(withIdentifier: "segueToEntry", sender: entry)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let entryViewController = segue.destination as? EntryViewController {
            if let entryToBeSent = sender as? Entry {
                entryViewController.entry = entryToBeSent
            }
        }
    }
    
}
