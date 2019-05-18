//
//  StoryboardInitializable.swift
//  MostStarted
//
//  Created by Mustafa Ozhan on 18/05/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import UIKit

protocol StoryboardInitializable {
    static var storyboardIdentifer: String { get }
}

extension StoryboardInitializable where Self: UIViewController {
    
    static var storyboardIdentifer: String {
        return String(describing: Self.self)
    }
    
    static func initFromStoryboard(name: String = "Main") -> Self {
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifer) as Self
    }
}
