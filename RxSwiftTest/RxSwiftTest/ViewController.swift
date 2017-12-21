//
//  ViewController.swift
//  RxSwiftTest
//
//  Created by zetafin on 2017/12/20.
//  Copyright © 2017年 赵宏亚. All rights reserved.
//

import UIKit
import RxSwift
class ViewController: UIViewController {
    
    var subscription: Disposable?
    
    
    
    @IBOutlet weak var textfield: UITextField!
    
    
    @IBAction func cancelObserve(_ sender: UIButton) {
        
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let scheduler = SerialDispatchQueueScheduler(qos: .default)
        let subscription = Observable<Int>.interval(0.3, scheduler: scheduler)
            .subscribe { (event) in
                print(event)
        }
        
//        Thread.sleep(forTimeInterval: 5.0)
        subscription.dispose() // 此代码可以停止上面的定时器
        
        
        let array = [1,2,3,4,5]
        
        let array2 = array.filter({$0 > 1}).map({$0 * 2}) // 4 6 8 10
        var indexGenerator = array2.makeIterator()
        print(indexGenerator)
        let first = indexGenerator.next()!
        let second = indexGenerator.next()!
        print("\(String(describing: first)) ******** \(String(describing: second))")
        
        
        
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

