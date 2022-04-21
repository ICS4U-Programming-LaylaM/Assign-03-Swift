//
//  Palindrome.swift
//
//  Created by Layla Michel
//  Created on 2022-04-11
//  Version 1.0
//  Copyright (c) 2022 IMH. All rights reserved.
//
//  This program takes a number and checks if it is a
//  palindrome or not. If not, it adds the reverse of the
//  number to itself and checks again.

import Foundation

var baseDepth = 0
var depthArray: [String] = []
var depthString: [String] = []
var strings: String

func depth(number: Int, depthInt: Int) -> [String] {
    let numberStr = String(number)
    var newString = ""

    // Create a reverse string of the numbers as strings
    for chars in numberStr {
        newString = String(chars) + newString
    }

    let reverseNum = Int(newString) ?? 0

    // Check if the number as a string is a palindrome
    if newString == numberStr {
        // Create array with the depth and palindrome number
        var returnArray: [String] = []
        returnArray.insert(String(depthInt), at: 0)
        returnArray.insert(String(reverseNum), at: 1)

        return returnArray
    } else {
        // Call the function again if the number is not
        // a palindrome
        return depth(number: number + reverseNum, depthInt: depthInt + 1)
    }
}

do {
    if CommandLine.argc < 2 {
        // Error message if no file is inputted
        print("Error: Text file needed.")
    } else {
        // Read command line arguments for file name
        let arguments = CommandLine.arguments
        let file: String = arguments[1]

        let set = try String(contentsOfFile: file, encoding: String.Encoding.utf8)
        let stringArray: [String] = set.components(separatedBy: "\n")

        var counter = 0
        // Put each string in the array in the depth function
        // and insert it to the depthArray
        for string in stringArray {
            let stringInt = Int(string) ?? -23847125624345235

            // Handles errors for non integers and negative integers
            if stringInt == -23847125624345235 {
                strings = "Error, is not an integer."
            } else if stringInt < 0 {
                strings = "Cannot not be negative."
            } else {
                depthArray = depth(number: Int(string) ?? 0, depthInt: baseDepth)
                // Create string that displays the depth of
                // each number and their palindrome
                strings = "The number \(stringArray[counter]) is " +
                "a depth \(depthArray[0]) palindrome. " +
                "Palindrome: \(depthArray[1])"
            }

            // Add to a new array
            depthString.append(strings)
            counter += 1
        }

        let joined = depthString.joined(separator: "\n")
        let saveToPath = "/home/runner/Assign-03-Swift/output.txt"

        do {
            // Put depth array into new file
            try joined.write(toFile: saveToPath, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Error with 'output.txt'")
        }

        print("Results added to 'output.txt'")
    }
} catch {
    // Error message if nonexistent file is inputted
    Swift.print("File does not exist.")
}
