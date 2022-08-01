//
//  SettingsViewController.swift
//  Game Clock
//
//  Created by Colin Weir on 6/16/22.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var game: Game?
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBAction func cancel(_ sender: UIButton) {
        self.performSegue(withIdentifier: "cancel", sender: self)
    }
    
    @IBAction func ok(_ sender: UIButton) {
        let minutes = self.picker.selectedRow(inComponent: 0)
        let seconds = self.picker.selectedRow(inComponent: 2)
        if let game = game {
            game.timeSetting = minutes * 60 + seconds
        }
        self.performSegue(withIdentifier: "saveSettings", sender: self)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 11
        } else if component == 2 {
            return 60
        } else {
            return 1
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 1 {
            return "min"
        } else if component == 3 {
            return "sec"
        } else {
            return "\(row)"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 && row == 0 && picker.selectedRow(inComponent: 2) == 0 {
            picker.selectRow(1, inComponent: 2, animated: true)
        }
        if component == 2 && row == 0 && picker.selectedRow(inComponent: 0) == 0 {
            picker.selectRow(1, inComponent: 2, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
        
        if let game = game {
            let minutes: Int = game.timeSetting / 60
            let seconds: Int = game.timeSetting % 60
            self.picker.selectRow(minutes, inComponent: 0, animated: false)
            self.picker.selectRow(seconds, inComponent: 2, animated: false)
        }

    }
}
