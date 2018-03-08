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

        let sequenceOfElements = Observable.of(1,2,3,4)
            .subscribe {
                event in
                print(event)
        }
        
        
        let generated = Observable.generate(initialState: 0, condition: { $0 < 20 }, iterate: { $0 + 4 })
        
        _ = generated.subscribe {
            print($0)
        }
        
        
        let error = NSError(domain: "Test", code: -1, userInfo: nil)
        
        let erroredSequence = Observable<Any>.error(error)
        
        _ = erroredSequence.subscribe() {
            print($0)
        }
        
        
        
        let deferredSequence: Observable<Int> = Observable.deferred {
            print("creating")
            
            return Observable.create { observer in
                
                print("emmiting")
                
                observer.onNext(0)
                
                observer.onNext(1)
                observer.onNext(2)
                
                return Disposables.create()
            }
        }
        
        
        
        _ = deferredSequence
            .subscribe() { event in
                
                print(event)
        }
        
        _ = deferredSequence
            .subscribe() { event in
                
                print(event)
        }
        
        
        
        
        let emptySequence = Observable<Int>.empty()
        
        
        _ = emptySequence.subscribe() { event in
            print("调取 ******** ")
            print(event)
        }
        
        
        let neverSequence = Observable<Int>.never()
        
        _ = neverSequence.subscribe() { _ in
            print("会打印这句话吗？？？？？？？")
            
        }
        
        
        let singleElementSequence = Observable.just("iOS")
        
        _ = singleElementSequence.subscribe() {
            print($0)
        }
        
        
        
    
        let subject = PublishSubject<Int>()
        
        _ = subject.subscribe() {
            print($0)
        }
        
        subject.onNext(1)
        subject.onNext(2)
        subject.onNext(3)
        subject.onNext(4)
        
        
        
        
        let subject1 = ReplaySubject<Int>.create(bufferSize: 1)
        
        _ = subject1.subscribe() { event in
            print("1 -> \(event)")
        }
        
        subject1.onNext(1)
        subject1.onNext(2)
        
        _ = subject1.subscribe() { event in
            print("2 -> \(event)")
        }
        
        subject1.onNext(3)
        subject1.onNext(4)
        
        print("======================")
        
        
        let behavior = BehaviorSubject(value: "z")
        
        _ = behavior.subscribe() {
            event in
            print("1 -> \(event)")
        }
        
        behavior.onNext("a")
        
        behavior.onNext("b")
        
        
        _ = behavior.subscribe() {
            event in
            print("2 -> \(event)")
        }
        
        behavior.onNext("c")
        behavior.onCompleted()
        
        print("======================")
        
        let variable = Variable("z")
        
        _ = variable.asObservable().subscribe({ (event) in
            print("1 -> \(event)")
        })
        
        
        variable.value = "a"
        variable.value = "b"
        
        _ = variable.asObservable().subscribe({ (event) in
            print("2 -> \(event)")
        })
        
        variable.value = "c"
        
        print("======================")
        
        let orignalSequence = Observable.of(1,2,3)
        
        _ = orignalSequence.map { number in
                number * 2
            }
            .subscribe {
                print($0)
        }
        
        print("======================")
        
        let sequenceInt = Observable.of(1,2,3,4,5,6)
        let sequenceString = Observable.of("A","B","C","D")
        
        _ = sequenceInt.flatMap { (event: Int) -> Observable<String> in
            
            print("event -> \(event)")
            
            return sequenceString
            
            } .subscribe {
                print($0)
        }
        
        print("======================")
        
        let sequenceToSum = Observable.of(0,1,2,3,4,5)
        
        print(sequenceToSum)
        
        _ = sequenceToSum.scan(0) {
            acum, elem in
            
            acum + elem
            
            
            } .subscribe {
                print($0)
        }
        
        print("======================")
        
        _ = Observable.of(0,1,2,3,4,5,6,7,8,9)
            .filter { (i) -> Bool in
                i % 2 == 0
            } .subscribe {
                print($0)
        }
        
        print("======================")
        
        _ = Observable.of(1,1,1,1,1,1,2,2,2,2,2,3,3,3,3,3,3,44,44,4,4)
            .distinctUntilChanged()
            .subscribe {
                print($0)
        }
        
        print("======================")
        
        _ = Observable.of(1,5,6,7,5,6,3,4,2,3)
        .take(4)
            .subscribe({ (i) in
                print(i)
            })
        
        print("======================")
        
        _ = Observable.of(1,2,3)
        .startWith(0)
            .subscribe({ (i) in
                print(i)
            })
        
        print("======================")
        
        
        let observer1 = PublishSubject<String>()
        
        let observer2 = PublishSubject<Int>()
        
        _ = Observable.combineLatest(observer1, observer2) {
            "\($0)\($1)"
            } .subscribe({ (str) in
                print(str)
            })
        
        observer1.onNext("iOS")
        observer1.onNext("swift")
        observer2.onNext(11)
        
        observer2.onNext(99)
        observer1.onNext("Rx")
        observer2.onNext(66666)
        
        print("======================")
        
        let stringObserver = PublishSubject<String>()
        
        let intObserver = PublishSubject<Int>()
        
        _ = Observable.zip(stringObserver, intObserver) {
            "\($0)\($1)"
            } .subscribe {
                print($0)
        }
        
        stringObserver.onNext("iOS")
        intObserver.onNext(6)
        stringObserver.onNext("Swift")
        intObserver.onNext(66)
        stringObserver.onNext("Rx")
        intObserver.onNext(666)
        stringObserver.onNext("不会打印")
        
        print("======================")
        
        
        let mergeObserver1 = PublishSubject<Int>()
        let mergeObserver2 = PublishSubject<Int>()
        
        _ = Observable.of(mergeObserver1, mergeObserver2)
//        .merge()
            // 加入只开一条线程，则只会展示第一个
            .merge(maxConcurrent: 1)
            .subscribe() { event in
                print(event)
        }
        
        mergeObserver1.onNext(20)
        mergeObserver2.onNext(40)
        
        mergeObserver1.onNext(60)
        mergeObserver2.onNext(1)
        
        mergeObserver1.onNext(10)
        mergeObserver2.onNext(30)
        mergeObserver2.onNext(50)
        
        print("======================")
        
        /**
         
         BehaviorSubject 在新的订阅对象订阅的时候会发送最近发送的事件，如果没有则发送一个默认值。
         
         variable 是基于 BehaviorSubject 的一层封装，它的优势是：不会被显式的终结。即：不会收到
         .Complete 和 .Error 这类的终结事件，它会主动在析构的时候发送 .Complete
         
         */
        
        
        let var1 = Variable(0)
        let var2 = Variable(200)
        let var3 = Variable(var1.asObservable())
        
        _ = var3
        .asObservable()
        .switchLatest()
            .subscribe {
                print($0)
        }
        
        var1.value = 1  // 0
        var1.value = 2 // 1
        var3.value = var2.asObservable() // 2
        var2.value = 201 // 200
        var1.value = 5 // 201
        
        
        print("======================")
        
        let sequenceThatFails = PublishSubject<Int>()
        
        let recoverySequence = Observable.of(100,200,300,400)
        
        _ = sequenceThatFails
            .catchError({ (error) -> Observable<Int> in
                return recoverySequence // 如果发生错误，则直接运行整个队列
            }) .subscribe() {
                print($0)
        }
        
        _ = sequenceThatFails
        .catchErrorJustReturn(100) // 如果发生错误，则直接返回100
            .subscribe {
                print($0)
        }
        
        sequenceThatFails.onNext(1)
        sequenceThatFails.onNext(2)
        sequenceThatFails.onNext(3)
        sequenceThatFails.onError(NSError(domain: "Test", code: 0, userInfo: nil))
        
        print("======================")
        
        var count = 1
        
        let funnyLookingSequence = Observable<Int>.create { (observer) -> Disposable in
            
            let error = NSError(domain: "Test", code: 0, userInfo: nil)
            
            observer.onNext(0)
            observer.onNext(1)
            observer.onNext(2)
            
            if count < 2 {
                observer.onError(error)
                count += 1
            }
            
            observer.onNext(3)
            observer.onNext(4)
            observer.onNext(5)
            
            observer.onCompleted()
            
            return Disposables.create()
        }
        
        
        
        _ = funnyLookingSequence
        .retry()
            .subscribe() {
                print($0)
        }
        
        print("======================")
        
        let sequenceOfInts = PublishSubject<Int>()
        
//        _ = sequenceOfInts
//            .subscribe(onNext: { (i) in
//                print("next *** \(i)")
//            }, onError: { (i) in
//                print("error *** \(i)")
//            }, onCompleted: {
//                print("********** Completed")
//            }, onDisposed: {
//                print("Disposed")
//            })
        
        
        _ = sequenceOfInts.do(onNext:
            {
                print("监听 event \($0)")
        },  onCompleted:
            {
                print("***** onCompleted")
        }).subscribe{
            
            print($0)
        }
        
        sequenceOfInts.onNext(1)
        // 如果出现error 直接默认调取disposed
//        sequenceOfInts.onError(NSError(domain: "呵呵", code: 0, userInfo: nil))
        sequenceOfInts.onCompleted()
        
        print("======================")
        
        
        let takeUntilSequence = PublishSubject<Int>()
        let whenThisSendsNextWordStops = PublishSubject<Int>()
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

