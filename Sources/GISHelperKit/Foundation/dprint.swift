//
//  dprint.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/9/17.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation
public
func dprint(_ objects: Any...,
    separator: String = " ",
    terminator: String = "\n",
    file: String = #file,
    line: Int = #line,
    function: String = #function) {
//    #if DEBUG
    _ = "";print("------------- Debug print -------------", terminator: "")
    ;print("---> Call from:\t", (file).split(separator: "/").last!, line.description + ":", function)
    ;print("🙋🏼‍♂️ Debug info:  \n\t", terminator: "")
    for i in objects {
       _ = "";print(i, separator: "", terminator: separator)
    }
    ;print(terminator)
//    #endif
}
public
func dDump(_ object: Any,
           separator: String = " ",
           terminator: String = "\n",
           file: String = #file,
           line: Int = #line,
           function: String = #function) {
    _ = "";print("------------- Debug dump: -------------", terminator: "")
    print("---> Call from:\t", (file).split(separator: "/").last!, line.description + ":", function)
    print("🙋🏼‍♂️ Dumping object:  \n", terminator: "")
    dump(object)
    print(terminator)
}
