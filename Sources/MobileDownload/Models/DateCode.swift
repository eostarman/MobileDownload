//
//  DateCode.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 10/22/20.
//

// https://sites.google.com/site/freshbeeronly/u-s-beer-list
// http://craftybeergirls.com/2018/11/12/date-code-confusion/
// https://thetaptakeover.com/2019/03/28/draught-diversions-beer-dating/
// see CommonTypes/DateCodeLabel.cs

import Foundation

public enum eDateCodeLabelFormat: Int, Codable {
    case None = 0
    case MMddy_XXXXXX_XXX = 1
    case MMddy = 2
    case Mddy = 3
    case yddd_XXXX = 4
    case St_Pauli_Girl = 5
    case MMddyy = 6
    case Tsingtao = 7
    case Mddyy_Skip_I = 8 // Formerly mike's hard lemonade format
    case dddy = 9
    case MM_dd_yy = 10
    case ddd_yy = 11
    case MM_yy = 12
    case dd_MM_y_Letter_Year_X_2012 = 13 // Formerly Newcastle
    case yyMdd = 14
    case yMMddXXX = 15
    case Pyramid_Brewing = 16
    case yddd = 17
    case yyddd = 18
    case MMMddyy = 19
    case dddyy = 20
    case ddMMMyy = 21
    case ddMMMyyyy = 22
    case ddMMy_Letter_Year_X_2013 = 23
    case ddMMyy = 24
    case ddMy_Skip_I = 25
    case MMddyyyy = 26
    case MMMddyyyy = 27
    case MMyy = 28
    case yyMMdd = 29
    case yyyyMMdd = 30
    case MMyyyy = 31
    case MMdd = 32
    case ddMyy_Skip_IJ = 33
    case MMMdd = 34
    case MMyyyydd = 35
    case dd_MM_yyyy = 36
    case Mddyy = 37
    case MMMyy = 38
    case ddd = 39
    case Mddy_Skip_I = 40
    case Anchor = 41
    case ddMyy_Skip_I = 42
    case ddMMy_Letter_Year_E_2015 = 43
    case Myydd = 44
    case MMMyyyy = 45
    case yyddd_Letter_Year = 46
    case yddd_Letter_Year_Skip_J = 47
    case ddMMyyyy = 48

    // When adding new entries here please also add matching data to DateCodeFormatInfo.
}

public struct DateCode: Equatable {
    public let labelFormat: eDateCodeLabelFormat
    public let dateCodeIsSellByDate: Bool
    public let year: Int?
    public let month: Int?
    public let day: Int?
    public let hour: Int?
    public let minute: Int?
    public let second: Int?

    public init(labelFormat: eDateCodeLabelFormat, dateCodeIsSellByDate: Bool, year: Int?, month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        self.labelFormat = labelFormat
        self.dateCodeIsSellByDate = dateCodeIsSellByDate
        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
        self.minute = minute
        self.second = second

    }

}
