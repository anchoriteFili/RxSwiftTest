# RxSwiftTest
练习使用RxSwift

[git地址](https://github.com/ReactiveX/RxSwift)<br>
[RxSwift使用教程](http://blog.csdn.net/Hello_Hwc/article/details/51859330)

#### 举例展示
---

```swift
Observable.just([1, 2, 3])
    .bind(to: pickerView2.rx.itemAttributedTitles) { _, item in
        return NSAttributedString(string: "\(item)",
                                    attributes: [
                                    NSAttributedStringKey.foregroundColor: UIColor.cyan,
                                    NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleDouble.rawValue
                                ])
    }
    .disposed(by: disposeBag)

pickerView2.rx.modelSelected(Int.self)
    .subscribe(onNext: { models in
        print("models selected 2: \(models)")
    })
    .disposed(by: disposeBag)
```

