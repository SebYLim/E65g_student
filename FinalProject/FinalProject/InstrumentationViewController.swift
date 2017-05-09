//
//  FirstViewController.swift
//  FinalProject
//
//  Created by Van Simmons on 1/15/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//  App Icon Credit: https://icons8.com/web-app/47036/runway
//  Tab Bar Icon Credit: https://icons8.com/web-app/5590/settings
//  Tab Bar Icon Credit: https://icons8.com/web-app/5570/picture

import UIKit

let finalProjectURL = "https://dl.dropboxusercontent.com/u/7544475/S65g.json"

var jsonKeys: [String] = []
var jsonValues: [[[Int]]] = [[[]]]
var jsonDictionary: [NSDictionary] = []

class InstrumentationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gridSizeTextField: UITextField!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var refreshRate: UITextField!
    @IBOutlet weak var slider: UISlider!
    
    var engine: StandardEngine!
    var jsonRawValue: String?
    
    override func viewDidLoad() {
        jsonGetter()
        super.viewDidLoad()
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    
    //MARK: TableView DataSource and Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basic", for: indexPath)
        let label = cell.contentView.subviews.first as! UILabel
        label.text = jsonKeys[indexPath.item]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var newData = jsonKeys
            newData.remove(at: indexPath.row)
            jsonKeys = newData as [String]
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        self.tableView.reloadData()
    }
    
    func jsonGetter() {
        let fetcher = Fetcher()
        fetcher.fetchJSON(url: URL(string:finalProjectURL)!) {
            (json: Any?, message: String?) in
            guard message == nil else {
                print(message ?? "nil")
                return
            }
            guard let json = json else {
                print("no json")
                return
            }
            print(json)
            let jsonArray = json as! NSArray
            for item in jsonArray {
                let nextItem = item as! NSDictionary
                let jsonTitle = nextItem["title"] as! String
                jsonKeys.append(jsonTitle)
                let jsonContents = nextItem["contents"] as! [[Int]]
                jsonValues.append(jsonContents)
            }
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }
    }
    
}
