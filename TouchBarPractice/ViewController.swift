//
//  ViewController.swift
//  QuickFunction
//
//  Created by Joshua Wu on 8/7/17.
//  Copyright © 2017 None. All rights reserved.
//

import Cocoa

import AppKit

@available(OSX 10.12.2, *)
extension ViewController: NSTouchBarDelegate {
    
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        let custom = NSCustomTouchBarItem(identifier: identifier)
        
        switch identifier {
        case NSTouchBarItemIdentifier.infoLabelItem:
            let label = NSTextField.init(labelWithString: NSLocalizedString("How do you feel today?", comment:""))
            custom.view = label
            
        case NSTouchBarItemIdentifier.joyEmojiItem:
            custom.view = NSButton(title: NSLocalizedString("😂", comment:""), target: self, action: #selector(buttonPressed(_:)))
            
        case NSTouchBarItemIdentifier.sadEmojiItem:
            custom.view = NSButton(title: NSLocalizedString("😟", comment:""), target: self, action: #selector(buttonPressed(_:)))
            
        case NSTouchBarItemIdentifier.angryEmojiItem:
            custom.view = NSButton(title: NSLocalizedString("😡", comment:""), target: self, action: #selector(buttonPressed(_:)))
            
        case NSTouchBarItemIdentifier.resetItem:
            custom.view = NSButton(title: NSLocalizedString("Reset", comment: ""), target: self, action: #selector(buttonPressed(_:)))
            
        default:
            return nil
        }
        return custom
    }
}

//
//
//

extension ViewController:NSTableViewDataSource{
    func numberOfRows(in tableView: NSTableView) -> Int {
        
        return tableViewData.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        
        // Assign identifiers on interface builder / storyboard
        //print (tableColumn?.identifier)
        
        return tableViewData[row][(tableColumn?.identifier)!]
    }
}

class ViewController: NSViewController{

    @IBOutlet weak var messageTextField: NSTextField!
    
    @IBOutlet weak var countATextField: NSTextField!
    @IBOutlet weak var countBTextField: NSTextField!
    @IBOutlet weak var countCTextField: NSTextField!
    @IBOutlet weak var countTotalTextField: NSTextField!
    
    // Initialize incrementer
    var countInputA = 0;
    var countInputB = 0;
    var countInputC = 0;
    var objCount = 0;
    
    var countInputTotal = 0;
    
    //
    //  Table initialization
    //
    
    @IBOutlet weak var tableView:NSTableView!
    
    var tableViewData = [NSDictionary()]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Remove initial empty cell
        tableViewData.removeAll();
        tableView.reloadData()
        
        // Table delegate initialization
        self.tableView.delegate = self as? NSTableViewDelegate
        self.tableView.dataSource = self
    }
    
    //
    //  Touchbar initialization
    //

    @available(OSX 10.12.2, *)
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self as NSTouchBarDelegate
        touchBar.customizationIdentifier = .hyftBar
        touchBar.defaultItemIdentifiers = [.infoLabelItem, .joyEmojiItem, .sadEmojiItem, .angryEmojiItem, .resetItem, .flexibleSpace, .otherItemsProxy]
        return touchBar
    }
    
    //
    //  Touchbar data functions
    //
    
    func getMessageBaseOnReaction(_ reaction: String) -> String {
        switch reaction {
        case "😂":
            countInputA += 1;
            // Assign count variables to UITextfields
            countATextField.stringValue = String(countInputA);
            
            // Determine total
            countInputTotal = countInputA + countInputB + countInputC
            countTotalTextField.stringValue = String(countInputTotal);
            
            tableViewData.append(["firstName":"Item "+String(objCount), "lastName":"😂"])
            objCount+=1;
            
            DispatchQueue.main.async() {
                if(self.objCount > 0){
                    self.tableView.scrollRowToVisible(self.objCount-1)
                }
            }
            
            tableView.reloadData()
            
            return "Being happy never goes out of style. - Lilly Pulitzer"
        case "😟":
            countInputB += 1;
            // Assign count variables to UITextfields
            countBTextField.stringValue = String(countInputB);
            
            // Determine total
            countInputTotal = countInputA + countInputB + countInputC
            countTotalTextField.stringValue = String(countInputTotal);
            
            tableViewData.append(["firstName":"Item "+String(objCount), "lastName":"😟"])
            objCount+=1;
            
            DispatchQueue.main.async() {
                if(self.objCount > 0){
                    self.tableView.scrollRowToVisible(self.objCount-1)
                }
            }
            
            tableView.reloadData()
            
            return "Sadness flies away on the wings of time. - Jean de La Fontaine"
        case "😡":
            countInputC += 1;
            // Assign count variables to UITextfields
            countCTextField.stringValue = String(countInputC);
            
            // Determine total
            countInputTotal = countInputA + countInputB + countInputC
            countTotalTextField.stringValue = String(countInputTotal);
            
            tableViewData.append(["firstName":"Item "+String(objCount), "lastName":"😡"])
            objCount+=1;
            
            DispatchQueue.main.async() {
                if(self.objCount > 0){
                    self.tableView.scrollRowToVisible(self.objCount-1)
                }
            }
            
            tableView.reloadData()
            
            return "To be angry is to revenge the faults of others on ourselves. - Alexander Pope"
            
            
        case "Reset":
            
            countInputA = 0;
            countInputB = 0;
            countInputC = 0;
            countInputTotal = 0;
            
            countATextField.stringValue = String(countInputA);
            countBTextField.stringValue = String(countInputB);
            countCTextField.stringValue = String(countInputC);
            countTotalTextField.stringValue = String(countInputTotal);
            
            // Reset table
            objCount = 0;
            tableViewData.removeAll();
            tableView.reloadData()
            
            return "Count values have been reset!"
            
        default:
            return "Look like our quote does not cater to this reaction"
        }
        
    }
    
    //Quotes are extracted from https://www.brainyquote.com
    func showMessageBaseOnReaction(_ reaction: String) {
        messageTextField.isHidden = false
        messageTextField.stringValue = getMessageBaseOnReaction(reaction)
    }
    
    //MARK: IBActions
    @IBAction func buttonPressed(_ sender: NSButton) {
        showMessageBaseOnReaction(sender.title)
    }
    
}



