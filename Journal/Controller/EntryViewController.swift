//
//  EntryViewController.swift
//  Journal
//
//  Created by 王珈玮 on 2022/5/5.
//

import UIKit

class EntryViewController: UIViewController{
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var entryTextView: UITextView!
    
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if entry == nil{
            //create entry
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                entry = Entry(context: context)
                entry?.date = datePicker.date
                entry?.text = "Today was ..."
                entryTextView.becomeFirstResponder()
            }
        }
        //edit entry
        entryTextView.text = entry!.text
        if let dateToBeShown = entry!.date {
            datePicker.date = dateToBeShown
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //make an entry
        if entry == nil{
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
                let entry = Entry(context: context)
                entry.date = datePicker.date
                entry.text = entryTextView.text
            }
        }
        
        entry?.date = datePicker.date
        entry?.text = entryTextView.text
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
    @IBAction func deletePressed(_ sender: Any) {
        if entry != nil {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
                context.delete(entry!)
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
}
