//
//  SimulationViewController.swift
//  Assignment4
//
//  Created by Sebastian Lim on 4/19/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//  Tab Bar Icon Credit: https://icons8.com/web-app/5570/picture
//  App Icon Credit: https://icons8.com/web-app/47036/runway
//

import UIKit

class SimulationViewController: UIViewController , GridViewDataSource, EngineDelegate {
    
    @IBOutlet weak var gridView: GridView!
    
    var engine: StandardEngine!
    var gridDataSource: GridViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let size = gridView.gridSize
        engine = StandardEngine(rows: size, cols: size)
        engine.delegate = self
        gridView.gridDataSource = self
        let nc = NotificationCenter.default
        let name = Notification.Name(rawValue: "EngineUpdate")
        nc.addObserver(forName: name, object: nil, queue: nil){ (n) in self.gridView.setNeedsDisplay() }
        // Do any additional setup after loading the view.
    }
    @IBAction func step(_ sender: Any) {
        engine.grid = self.engine.step()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public subscript (row: Int, col: Int) -> CellState {
        get { return engine.grid[row, col] }
        set { engine.grid[row,col] = newValue }
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        self.gridView.setNeedsDisplay()
    }
}
