//
//  ViewController.swift
//  Todo
//
//  Created by yutaoma on 2017/8/31.
//  Copyright © 2017年 yutaoma. All rights reserved.
//

import UIKit

var todos: [Todomodel] = []
var filteredTodos: [Todomodel] = []



func dateFromString(dateStr: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.date(from: dateStr)
    return date
}



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate{
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        todos = [Todomodel(id: "1", image: "child-selected", title: "1.go to play", date:
                     dateFromString(dateStr: "2017-9-1")!),
                 Todomodel(id: "2", image: "shopping-cart-selected", title: "2.go shopping",date:dateFromString(dateStr: "2017-9-2")!),
                 Todomodel(id: "3", image: "phone-selected", title: "3.make a phone call", date:
                     dateFromString(dateStr: "2017-9-3")!),
                 Todomodel(id: "4", image: "travel-selected", title: "4.go travelling", date:
                     dateFromString(dateStr: "2017-9-3")!)]
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        
        //初始隐藏 search bar
//        var contentoffset = tableView.contentOffset
//        contentoffset.y += searchDisplayController!.searchBar.frame.size.height
//        tableView.contentOffset = contentoffset
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditTodo" {
            var vc  = segue.destination as! DetailViewController
            var indexPath = tableView.indexPathsForSelectedRows

            if let index = indexPath {
                vc.todo = todos[index[0].row]   // 需要知道各个变量的类型
            }
        }
        
    }
    
    
    // Mark - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchDisplayController?.searchResultsTableView {
            return filteredTodos.count
        } else {
            return todos.count
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "todoCell")! as UITableViewCell
        
        var todo : Todomodel
        
        if tableView == searchDisplayController?.searchResultsTableView {
            todo = filteredTodos[indexPath.row] as Todomodel
        } else {
            todo = todos[indexPath.row] as Todomodel
        }
        
         /*
         ******导入的数据要与行数相对应！！！！！！！！******
         */
        var image = cell.viewWithTag(101) as! UIImageView
        var title = cell.viewWithTag(102) as! UILabel
        var date = cell.viewWithTag(103) as! UILabel
        
        image.image = UIImage(named: todo.image)
        title.text = todo.title
        
        //获取时间
        //显示当地时间的格式
        let locale = NSLocale.current //获取当地地点
        let dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd", options: 0, locale: locale) //输入参数，数据的格式，场所
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        date.text = dateFormatter.string(from: todo.date)
        
        return cell
    }
    
    
    // Mark -UITableViewDelegate
    
    //实现手势左滑删除功能
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
       //判断是否是删除状态
        if editingStyle == UITableViewCellEditingStyle.delete {
            todos.remove(at: indexPath.row)
            //无动画 self.tableView.reloadData()
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic); //动画
        
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "i want to delete"
        
    }
    
    //实现cell移动
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todo =  todos.remove(at: sourceIndexPath.row)
        todos.insert(todo, at: destinationIndexPath.row)
    }
    
    
    //实现 search 功能
    func searchDisplayController(_ controller: UISearchDisplayController, shouldReloadTableForSearch searchString: String?) -> Bool {
        filteredTodos = todos.filter{ $0.title.range(of: searchString!) != nil }
        return true
    }

    //
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 71
    }
    
     //unwind 返回指定页的操作，可以进行传递数据等操作
    @IBAction func close(segue: UIStoryboardSegue) {
        print("close")
        tableView.reloadData()  //tableview 数据重载
        
    }
    

}

