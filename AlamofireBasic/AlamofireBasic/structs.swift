//
//  structs.swift
//  AlamofireBasic
//
//  Created by 송종근 on 2021/01/10.
//
import UIKit
struct DummyData:Codable {
    let data:[PersonInfo]
    let total:Int
    let page:Int
    let limit:Int
    let offset:Int
}

struct PersonInfo:Codable {
    let id:String
    let email:String
    let firstName:String
    let picture:URL?
    let lastName:String
    let title:String
}

struct PersonDetail:Codable {
    let id:String
    let phone:String
    let lastName:String
    let firstName:String
    let location:Location?
    let email:String
    let gender:String
    let title:String
    let registerDate:String
    let picture:URL
    let dateOfBirth:String
}

struct Location:Codable {
    let state:String
    let street:String
    let city:String
    let timezone:String
    let country:String
}
