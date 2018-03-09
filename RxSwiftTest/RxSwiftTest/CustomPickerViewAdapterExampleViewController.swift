//
//  CustomPickerViewAdapterExampleViewController.swift
//  RxSwiftTest
//
//  Created by zetafin on 2018/3/9.
//  Copyright © 2018年 赵宏亚. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CustomPickerViewAdapterExampleViewController: UIViewController {
    
    
    @IBOutlet weak var pickView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.just([[1, 2, 3],[5, 8, 13], [21, 34]])
            .bind(to: pickView.rx.items(adapter: PickerViewViewAdapter()))
            .disposed(by: disposeBag)
        
        pickView.rx.modelSelected(Int.self)
            .subscribe(onNext: { models in
                print(models)
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

final class PickerViewViewAdapter:
    NSObject,
    UIPickerViewDataSource,
    UIPickerViewDelegate,
    RxPickerViewDataSourceType,
SectionedViewDataSourceType {
    
    typealias Element = [[CustomStringConvertible]]
    private var items: [[CustomStringConvertible]] = []
    
    
    func model(at indexPath: IndexPath) throws -> Any {
        return items[indexPath.section][indexPath.row]
    }
    
    func numberOfComponents(in pickView: UIPickerView) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel()
        label.text = items[component][row].description
        label.textColor = UIColor.orange
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, observedEvent: Event<Element>) {
        Binder(self) { (adapter, items) in
            adapter.items = items
            pickerView.reloadAllComponents()
        }.on(observedEvent)
    }
}






