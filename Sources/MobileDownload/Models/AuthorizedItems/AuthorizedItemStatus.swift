//
//  AuthorizedItemStatus.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/3/20.
//

public enum AuthorizedItemStatus: CustomStringConvertible {
    case OK
    case ErasedItem
    case NoCanSell
    case PrivateLabelRestriction
    case MissingLiquorLicense
    case ExpiredLiquorLicense
    case CannotBuyStrongBeer
    case CannotBuyWine
    case UnauthorizedItem
    case UnauthorizedItemNotInCustomersBrandFamilies
    case UnauthorizedItemNotInTerritorysBrandFamilies
    case AllocationRestriction
    case ErasedCustomer
    case NoPermit
    case SuspendedPermit
    case DelinquentPermit
    case ExpiredPermit
    case Blacklisted
    case NoRedBullSalesToOffPremiseAccounts
    case CountyBlacklisted
    case NoSellHoldCode
    case NotScheduledPreseller
    case NoCanIssue
    case NotInWarehouseSellableProductSet
    case DisallowedProductClass
    case ProductIsInNonReturnProductSet
    case NoSellAlcoholStateNonCompliance
    case CancelledPermit
    case UnsellableForWarehouse

    public var description: String {
        // Use Internationalization, as appropriate.
        switch self {
        case .OK: return "OK"
        case .ErasedItem: return "Erased item"
        case .ErasedCustomer: return "Erased customer"
        case .NoCanSell: return "Item is not flagged as 'can-sell'"
        case .Blacklisted: return "Item is blacklisted"
        case .NoRedBullSalesToOffPremiseAccounts: return "Red Bull may not be sold to off-premise accounts"
        case .PrivateLabelRestriction: return "Private label restriction"
        case .MissingLiquorLicense: return "Alcoholic item (customer has no liquor license)" // KJQ 4/4/08 no longer explicitly forbidden, see other 4/4/08 comments
        case .ExpiredLiquorLicense: return "Alcoholic item (customer has expired liquor license)"
        case .CannotBuyStrongBeer: return "Customer can't buy strong beer"
        case .CannotBuyWine: return "Customer can't buy wine"
        case .UnauthorizedItem: return "Unauthorized item"
        case .UnauthorizedItemNotInCustomersBrandFamilies: return "Item is not in customer's brand families"
        case .UnauthorizedItemNotInTerritorysBrandFamilies: return "Item is not in territory's brand families"
        case .AllocationRestriction: return "Item sold only via allocation (customer has no allocation)"
        case .NoPermit: return "Item requires a permit for sale"
        case .SuspendedPermit: return "Customer's permit is suspended"
        case .DelinquentPermit: return "Customer's permit is delinquent"
        case .ExpiredPermit: return "Customer's permit is expired prior to delivery date"
        case .CancelledPermit: return "Customer's permit is cancelled"
        case .CountyBlacklisted: return "Brand is not authorized for this county"
        case .NoSellHoldCode: return "Hold code is applied"
        case .NotScheduledPreseller: return "Not scheduled to presell for this customer"
        case .NoCanIssue: return "Item is not issuable, can not return"
        case .NotInWarehouseSellableProductSet: return "Item is not in the customer's warehouse sellable product set"
        case .UnsellableForWarehouse: return "Item is flagged as unsellable from the customer's warehouse"
        case .DisallowedProductClass: return "Item is not in allowed product class for customer"
        case .ProductIsInNonReturnProductSet: return "Item is in a non returnable product set"
        case .NoSellAlcoholStateNonCompliance: return "Customer is on the state's noncompliance list"
        }
    }
}
