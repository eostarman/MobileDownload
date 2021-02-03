//  Created by Michael Rutherford on 2/3/21.

import Foundation
import MoneyAndExchangeRates

extension Money {
    
    public func converted(to currency: Currency) -> Money? {
        self.currency == currency ? self : mobileDownload.exchange(self, to: currency)
    }
    
    public func converted(to currency: Currency, withDecimals numberofDecimals: Int) -> Money? {
        guard let result = self.currency == currency ? self : mobileDownload.exchange(self, to: currency) else {
            return nil
        }
        
        let roundedResult = result.withDecimals(numberOfDecimals)
        return roundedResult        
    }
}
