//
//  File.swift
//  
//
//  Created by Michael Rutherford on 6/17/21.
//

import Foundation

public struct LegacySafeString {
    
//    let backspace = Character("\u{8}")
//    let tab = Character("\t")
//    let carriageReturn = Character("\r")
//    let newLine = Character("\n")
//    let formFeed = Character("\u{C}")
    
    public static func getsafeMobileString(_ string: String?) -> String? {
        guard let string = string else {
            return nil
        }
        
        return getsafeMobileString(string)
    }
    
    public static func getsafeMobileString(_ string: String) -> String {
        let value = string
            .replacingOccurrences(of: "\u{8}", with: " ")           // Replace('\b', ' ') just in case
            .replacingOccurrences(of: "\t", with: "\u{8}t")         // Replace("\t", "\bt")
            .replacingOccurrences(of: "\u{C}", with: "\u{8}f")      // Replace("\f", "\bf")
            .replacingOccurrences(of: "\r", with: "\u{8}r")         // Replace("\r", "\br")
            .replacingOccurrences(of: "\n", with: "\u{8}n")         // Replace("\n", "\bn")

        if value != string {
            return "\u{8}" + value
        }
        
        return value
    }
    
    public static func decodeSafeMobileString(safeString: String) -> String? {
        if safeString.isEmpty {
            return nil
        }
        
        if safeString.prefix(1) != "\u{8}" {
            return safeString
        }
        
        let value = safeString.dropFirst(1)
            .replacingOccurrences(of: "\u{8}t", with: "\t")         // Replace("\bt", "\t")
            .replacingOccurrences(of: "\u{8}f", with: "\u{C}")      // Replace("\bf", "\f")
            .replacingOccurrences(of: "\u{8}r", with: "\r")         // Replace("\br", "\r")
            .replacingOccurrences(of: "\u{8}n", with: "\n")         // Replace("\bn", "\n")
        
        return value
        

//        let backspace = Character("\u{8}")
//        let tab = Character("\t")
//        let carriageReturn = Character("\r")
//        let newLine = Character("\n")
//        let formFeed = Character("\u{C}")
//
//        if let firstCharacter = safeString.first {
//            if firstCharacter != backspace {
//                return safeString
//            }
//        } else {
//            return nil
//        }
//
//        var decoded: [Character] = []
//
//        var isFirstCharacter = true
//        var foundBackspace = false
//
//        for char in safeString {
//            if isFirstCharacter {
//                if char != backspace {
//                    return safeString
//                }
//                isFirstCharacter = false
//                continue
//            }
//            if char == backspace {
//                foundBackspace = true
//                continue
//            }
//            if foundBackspace {
//                foundBackspace = false
//
//                switch char {
//                case "t":
//                    decoded.append(tab)
//                case "n":
//                    decoded.append(newLine)
//                case "f":
//                    decoded.append(formFeed)
//                case "r":
//                    decoded.append(carriageReturn)
//                default:
//                    decoded.append(char)
//                }
//
//                continue
//            }
//
//            decoded.append(char)
//        }
//
//        let result = String(decoded)
//
//        return result
    }
}
