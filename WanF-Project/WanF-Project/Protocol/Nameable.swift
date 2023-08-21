//
//  Nameable.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/08.
//

/// A class of Type whose instances hold 'name', conforming Identifiable
public protocol Nameable: Identifiable {
    var id: Int { get }
    var name: String { get }
}
