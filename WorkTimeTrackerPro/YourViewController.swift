//
//  YourViewController.swift
//  WorkTimeTrackerPro
//
//  Created by Bootan Majeed on 2023-12-16.
//

import Foundation
import UIKit

import QuickLook

class DocumentInteractionDelegate: NSObject, UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return UIApplication.shared.windows.first!.rootViewController!
    }
    
    // Implement other delegate methods if needed
}


