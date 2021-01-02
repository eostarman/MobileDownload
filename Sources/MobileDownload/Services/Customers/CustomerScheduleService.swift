//
//  CustomerScheduleService.swift
//  MobileBench
//
//  Created by Michael Rutherford on 8/11/20.
//

import Foundation

public struct CustomerScheduleService {
    public let customer: CustomerRecord

    public init(customer: CustomerRecord) {
        self.customer = customer
    }

    /// the customer's delivery window (or windows) - e.g. "9:00 AM - 11:00 AM and 1:00 PM - 5:00 PM"
    public struct DeliveryWindow {
        let deliveryWindow1Start: String
        let deliveryWindow1End: String
        let deliveryWindow2Start: String
        let deliveryWindow2End: String

        func getDescription(startTime: String, endTime: String) -> String? {
            if startTime.isEmpty, endTime.isEmpty {
                return nil
            }

            if startTime.isEmpty {
                return endTime
            }

            if endTime.isEmpty {
                return startTime
            }

            return "\(startTime) - \(endTime)"
        }

        var description: String? {
            let window1 = getDescription(startTime: deliveryWindow1Start, endTime: deliveryWindow1End)
            let window2 = getDescription(startTime: deliveryWindow2Start, endTime: deliveryWindow2End)

            if let window1 = window1 {
                if let window2 = window2 {
                    return "\(window1) and \(window2)"
                }
            }

            return window1 ?? window2
        }
    }

    public func getDeliveryWindow() -> String? {
        let deliveryWindow = DeliveryWindow(deliveryWindow1Start: customer.deliveryWindow1Start, deliveryWindow1End: customer.deliveryWindow1End, deliveryWindow2Start: customer.deliveryWindow2Start, deliveryWindow2End: customer.deliveryWindow2End)

        let description = deliveryWindow.description

        return description
    }

    /*
     BusinessHourInfo _businessHourInfo;
            class BusinessHourInfo
            {
                public string OpenTimeRaw { get; internal set; }
                public string CloseTimeRaw { get; internal set; }
                public string CrossStreets { get; internal set; }
                public bool IsClosed { get; internal set; }
                public string ScheduleStatusNote { get; internal set; }
                public string DeliveryWindowsOverrideBlob { get; internal set; }
                public DateTime? MobilePresellCutoffTimeOverride { get; internal set; }
                public eScheduleActiveStatus ScheduleActiveStatus { get; internal set; }
                public ShortDate ScheduleActiveFromDate { get; internal set; }
                public ShortDate ScheduleActiveThruDate { get; internal set; }

                public bool HasData()
                {
                    return (OpenTimeRaw != null ||
                        CloseTimeRaw != null ||
                        CrossStreets != null ||
                        IsClosed != false ||
                        ScheduleStatusNote != null ||
                        DeliveryWindowsOverrideBlob != null ||
                        MobilePresellCutoffTimeOverride != null ||
                        ScheduleActiveStatus != DefaultScheduleActiveStatus ||
                        ScheduleActiveFromDate != DefaultScheduleActiveFromDate ||
                        ScheduleActiveThruDate != DefaultScheduleActiveThruDate);
                }
            }

            public string OpenTimeRaw { get { return _businessHourInfo == null ? null : _businessHourInfo.OpenTimeRaw; } }
            public string OpenTimeFormatted { get { return FormatRawTimeString(OpenTimeRaw); } }
            public string CloseTimeRaw { get { return _businessHourInfo == null ? null : _businessHourInfo.CloseTimeRaw; } }
            public string CloseTimeFormatted { get { return FormatRawTimeString(CloseTimeRaw); } }
            public bool HasOpenAndCloseTimes
            {
                get
                {
                    if (string.IsNullOrEmpty(OpenTimeRaw))
                        return false;

                    if (string.IsNullOrEmpty(CloseTimeRaw))
                        return false;

                    return true;
                }
            }

            public string CrossStreets { get { return _businessHourInfo == null ? null : _businessHourInfo.CrossStreets; } }

            public bool IsClosed { get { return _businessHourInfo == null ? false : _businessHourInfo.IsClosed; } }
            public string ScheduleStatusNote { get { return _businessHourInfo == null ? null : _businessHourInfo.ScheduleStatusNote; } }

            /// <summary>
            /// Not for public use.  Use <see cref="GetPresellCutoffTime"/> instead so all overrides and fall-thrus are taken into account.
            /// </summary>
            DateTime? MobilePresellCutoffTimeOverride { get { return _businessHourInfo == null ? null : _businessHourInfo.MobilePresellCutoffTimeOverride; } }
            public DateTime? GetPresellCutoffTime(MobileDownload download)
            {
                if (MobilePresellCutoffTimeOverride.HasValue)
                    return MobilePresellCutoffTimeOverride;

                var warehouse = download.Warehouse(download.HandheldRecord.RouteWhseNid);
                if (warehouse.NextDayDeliveryCutoffTime.HasValue)
                    return warehouse.NextDayDeliveryCutoffTime;

                return null;
            }

            static readonly eScheduleActiveStatus DefaultScheduleActiveStatus = eScheduleActiveStatus.YearRound;
            public eScheduleActiveStatus ScheduleActiveStatus { get { return _businessHourInfo == null ? DefaultScheduleActiveStatus : _businessHourInfo.ScheduleActiveStatus; } }
            static readonly ShortDate DefaultScheduleActiveFromDate = new ShortDate(2019, 1, 1);
            public ShortDate ScheduleActiveFromDate { get { return _businessHourInfo == null ? DefaultScheduleActiveFromDate : _businessHourInfo.ScheduleActiveFromDate; } }
            static readonly ShortDate DefaultScheduleActiveThruDate = new ShortDate(2019, 12, 31);
            public ShortDate ScheduleActiveThruDate { get { return _businessHourInfo == null ? DefaultScheduleActiveThruDate : _businessHourInfo.ScheduleActiveThruDate; } }

     */
}
