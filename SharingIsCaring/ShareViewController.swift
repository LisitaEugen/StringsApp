//
//  ShareViewController.swift
//  SharingIsCaring
//
//  Created by Evgheni Lisita on 07.02.21.
//

import UIKit
import Social
import MobileCoreServices


class ShareViewController: SLComposeServiceViewController {
    private var textString: String = ""
    
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }
    
    override func didSelectPost() {
        print("didSelectPost")
        
        let extensionItem = extensionContext?.inputItems[0] as! NSExtensionItem
        let contentTypeText = kUTTypeText as String
        
        for attachment in extensionItem.attachments! {
            if attachment.isText {
                attachment.loadItem(forTypeIdentifier: contentTypeText, options: nil, completionHandler: { (results, error) in
                    let text = results as! String
                    self.textString = text
                    
                    let sharedDefault = UserDefaults(suiteName: "group.com.fox.StringsApp")!
                    sharedDefault.set(text, forKey: "shared_text")
                    
                    //save history
                    
                    var history = sharedDefault.stringArray(forKey: "sharing_history") ?? [String]()
                    history.append(text)
                    
                    sharedDefault.set(history, forKey: "sharing_history")
                    
                    print(history)
                })
            }
        }
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
        
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }
    
}

extension NSItemProvider {
    var isURL: Bool {
        return hasItemConformingToTypeIdentifier(kUTTypeURL as String)
    }
    var isText: Bool {
        return hasItemConformingToTypeIdentifier(kUTTypeText as String)
    }
}

