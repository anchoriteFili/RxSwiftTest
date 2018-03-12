//
//  SimplePickerViewExampleViewController.swift
//  RxSwiftTest
//
//  Created by zetafin on 2018/3/9.
//  Copyright © 2018年 赵宏亚. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class SimplePickerViewExampleViewController: UIViewController {
    
    @IBOutlet weak var pickView1: UIPickerView!
    @IBOutlet weak var pickView2: UIPickerView!
    @IBOutlet weak var pickView3: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.just([1,2,3])
            .bind(to: pickView1.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: disposeBag)
        
        pickView1.rx.modelSelected(Int.self)
            .subscribe(onNext: { models in
                print("models selected 1: \(models)")
            })
            .disposed(by: disposeBag)
        
        
        Observable.just([1, 2, 3])
            .bind(to: pickView2.rx.itemAttributedTitles) { _, item in
                return NSAttributedString(string: "\(item)",
                    attributes:[
                        NSAttributedStringKey.foregroundColor: UIColor.cyan,
                        NSAttributedStringKey.underlineStyle:
                        NSUnderlineStyle.styleDouble.rawValue
                    ])
            }
            .disposed(by: disposeBag)
        
        pickView2.rx.modelSelected(Int.self)
            .subscribe(onNext: { models in
                print("model selected 2: \(models)")
            })
            .disposed(by: disposeBag)
        
        Observable.just([UIColor.red, UIColor.green, UIColor.blue])
            .bind(to: pickView3.rx.items) { _, item, _ in
                
                let view = UIView()
                view.backgroundColor = item
                return view
            }
            .disposed(by: disposeBag)
        
        pickView3.rx.modelSelected(UIColor.self)
            .subscribe(onNext: { models in
                print("models selected 3: \(models)")
            })
            .disposed(by: disposeBag)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
