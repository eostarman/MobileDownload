//  Created by Michael Rutherford on 2/3/21.

import Foundation
import MoneyAndExchangeRates

extension Money {
    
    public func converted(to currency: Currency) -> Money? {
        self.currency == currency ? self : mobileDownload.exchange(self, to: currency, numberOfDecimals: currency.numberOfDecimals)
    }
    
    public func converted(to currency: Currency, numberofDecimals: Int) -> Money? {
        guard let result = self.currency == currency ? self : mobileDownload.exchange(self, to: currency, numberOfDecimals: numberofDecimals) else {
            return nil
        }
        
        return result
    }
}
