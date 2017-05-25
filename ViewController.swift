//
//  ViewController.swift
//  ExpendCell
//
//  Created by guchengfeng on 5/10/17.
//  Copyright © 2017 HCFDATA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    var models = [FrameModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        table.register(UINib.init(nibName: "ExpendTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ExpendTableViewCell")
        
        let m = FrameModel(content: "<img src=\"http://cc.cocimg.com/api/uploads/170427/9269ac04cd5f48a83361e81ccc5d447d.jpg\" alt=\"关于内存泄漏，还有哪些是你不知道的？\" title=\"关于内存泄漏，还有哪些是你不知道的？\" /><p>欲穷千里目欲穷千里目欲穷千里目</p><img src=\"http://cc.cocimg.com/api/uploads/170427/9269ac04cd5f48a83361e81ccc5d447d.jpg\" alt=\"关于内存泄漏，还有哪些是你不知道的？\" title=\"关于内存泄漏，还有哪些是你不知道的？\" />")
        let m1 = FrameModel(content: "<p>宁静以致远，淡泊以明志宁静以致远，\n淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志宁静以致远，淡泊以明志</p><img src=\"http://cc.cocimg.com/api/uploads/170427/9269ac04cd5f48a83361e81ccc5d447d.jpg\" alt=\"关于内存泄漏，还有哪些是你不知道的？\" title=\"关于内存泄漏，还有哪些是你不知道的？\" />")
        
        models = [m1,m]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Mark: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count;
    }
    
    // Mark: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ExpendTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ExpendTableViewCell", for: indexPath) as! ExpendTableViewCell
        cell.viewModel = models[indexPath.row]
        cell.textLabel?.text = cell.viewModel.isOpen ? nil : "欲思其利，必虑其害；欲思其成，必虑其败。草木本无意，何求美人折？"
        cell.expendClouser = { [weak self] in
            self?.table.reloadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let m = models[indexPath.row]
        let h = m.contentHeight > 0 ? m.contentHeight + 20 : 60
        return h
    }
    
}

