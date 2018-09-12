//
//  ViewController.swift
//  Flames-RelationshipMeter
//
//  Created by smac on 9/12/18.
//  Copyright © 2018 Sathish. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var Name1 : UITextField!
    @IBOutlet weak var Name2 : UITextField!
    @IBOutlet weak var RelationLab : UILabel!
    @IBOutlet weak var progressBar: ProgressBarView!
    @IBOutlet weak var percentage : UILabel!
    
    var timer: Timer!
    var progressCounter:Float = 0
    let duration:Float = 10.0
    var progressIncrement:Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressIncrement = 1.0/duration
        //  timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.showProgress), userInfo: nil, repeats: true)
        Name2.delegate = self
        Name1.delegate = self
        UITextField.connectFields(fields: [self.Name1, self.Name2])
        Name1.addTarget(self, action: #selector(flamesGame), for: UIControlEvents.editingChanged)
        Name2.addTarget(self, action: #selector(flamesGame), for: UIControlEvents.editingChanged)
    }
    //    @objc func showProgress() {
    //        print("before progressCounter \(progressCounter)")
    //        if(progressCounter > 1.0){timer.invalidate()}
    //        progressBar.progress = progressCounter
    //        progressCounter = progressCounter + progressIncrement
    //        print("after progressCounter \(progressCounter)")
    //    }
    
    
    func showProgress(getValue : Float) {
        progressBar.progress = getValue
    }
    @objc func flamesGame(){
//        guard Name1.text?.count == 0 || Name2.text?.count == 0 else{
//             return
//        }
        if (Name1.text! != "") && (Name2.text! != "") {
            print("check...")
            let FlamesName1 = Name1.text!.replacingOccurrences(of: " ", with: "")
            let FlamesName2 = Name2.text!.replacingOccurrences(of: " ", with: "")
            test1(FlamesName1: FlamesName1, FlamesName2: FlamesName2)
        }else if (Name1.text! != "") || (Name2.text! != ""){
            print("check... enter..")
            RelationLab.text = "Kindly Enter Partner Name"
            showProgress(getValue: 0.0)
            percentage.text = "00"
        }else{
            RelationLab.text = "Kindly Enter Names"
            showProgress(getValue: 0.0)
            percentage.text = "00"
        }
    }
    func test1(FlamesName1: String , FlamesName2: String){
        let name1 = FlamesName1
        let name2 = FlamesName2
        var name1Arr = Array(name1)
        var name2Arr = Array(name2)
        var name3Arr = [Character]()
        print("before",name1Arr,name2Arr, separator:"and")
        for i in 0..<name1Arr.count{
            for j in 0..<name2Arr.count{
                if name1Arr[i] == name2Arr[j]{
                    name1Arr[i] = "-"
                    name2Arr[j] = "-"
                    break
                }
            }
        }
        for i in 0..<name1Arr.count{
            if name1Arr[i] != "-"{
                name3Arr.append(name1Arr[i])
            }
        }
        for j in 0..<name2Arr.count{
            if name2Arr[j] != "-"{
                name3Arr.append(name2Arr[j])
            }
        }
        print("UnComman letter = \(name3Arr)")
        var flames = ["f","l","a","m","e","s"]
        let percent = (Float(name3Arr.count) / (Float(name1Arr.count) + Float(name2Arr.count)))
        let showPercent = String(format: "%.2f", percent*100)
        percentage.text = "\(showPercent)%"
        print("percent \(percent)")
        let finalArrCount = name3Arr.count
        var str = 1
        for x in stride(from: 6, to: 1, by: -1){
            var g = ((finalArrCount % x)+str)-1
            if (g>x)
            {
                g = g % x
            }
            if g == 0
            {
                g = flames.count
            }
            flames.remove(at: g-1)
            str = g
        }
        let flames1 = flames[0]
        switch flames1{
        case "f":
            RelationLab.text = "Relationship is Friends."
        case "l":
            RelationLab.text = "Relationship is Love."
        case "a":
            RelationLab.text = "Relationship is Affection."
        case "m":
            RelationLab.text = "Relationship is Marriage."
        case "e":
            RelationLab.text = "Relationship is Enemy."
        case "s":
            RelationLab.text = "Relationship is Sister."
        default:
            RelationLab.text = "Relationship Not found"
        }
        flames = ["f","l","a","m","e","s"]
        showProgress(getValue: percent)
    }
}

extension UITextField {
    class func connectFields(fields:[UITextField]) -> Void {
        guard let last = fields.last else {
            return
        }
        for i in 0 ..< fields.count - 1 {
            fields[i].returnKeyType = .next
            fields[i].addTarget(fields[i+1], action: #selector(UIResponder.becomeFirstResponder), for: .editingDidEndOnExit)
        }
        last.returnKeyType = .done
        last.addTarget(last, action: #selector(UIResponder.resignFirstResponder), for: .editingDidEndOnExit)
    }
}
