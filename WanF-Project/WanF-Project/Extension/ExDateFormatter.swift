//
//  ExDateFormatter.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/24.
//

import Foundation

extension DateFormatter {
    
    func wanfDateFormatted(from string: String) -> String? {
        let beforeFormatter = DateFormatter()
        beforeFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
        
        guard let date = beforeFormatter.date(from: string) else { return nil }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd h:mm a"
        
        return formatter.string(from: date)
    }
    
    func wanfDateFormatted(from date: Date) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd h:mm a"
        
        return formatter.string(from: date)
    }
}
