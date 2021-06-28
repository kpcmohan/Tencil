//
//  Common.swift
//  TencilUI
//
//  Created by Manu Puthoor on 26/06/21.
//

import UIKit

class Common {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
}
