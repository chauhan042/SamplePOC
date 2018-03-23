//
//  HomeViewController.swift
//  AugmentedTranslationSample
//
//  Created by Nitin Singh Chauhan on 2/5/18.
//  Copyright © 2018 Nitin Singh Chauhan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let demos = ["Cognitive Services OCR","Barcode", "Barcode Generator", "Constraint","PhotoEditor", "FacialRecognition"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        let text = demos[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = text
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.textColor = .black
    
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let identifier = tableView.cellForRow(at: indexPath)!.textLabel!.text!
        
        
        
        switch identifier {
            
            
        case "Cognitive Services OCR", "Barcode", "Barcode Generator", "Constraint", "PhotoEditor", "FacialRecognition":
            self.performSegue(withIdentifier: identifier, sender: self)
            
            
        default:
            let alert = UIAlertController(title: "Missing", message: "This hasn't been implemented yet.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.navigationItem.title = demos[(tableView.indexPathForSelectedRow! as NSIndexPath).row]
        tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
    }

}
