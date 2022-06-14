﻿using System;
using Microsoft.ApplicationInsights;

namespace ErikEJ.SqlCeToolbox.Helpers
{
    /// <summary>
    /// Reports anonymous usage through ApplicationInsights
    /// </summary>
    public static class Telemetry
    {
        private static TelemetryClient _telemetry;
        //private static DTEEvents _events;

        /// <summary>
        /// Initializes the telemetry client.
        /// </summary>
        public static void Initialize(string version, string vsVersion, string telemetryKey)
        {
            if (_telemetry != null)
                return;

            _telemetry = new TelemetryClient();
            _telemetry.Context.Session.Id = Guid.NewGuid().ToString();
            _telemetry.Context.User.Id = (Environment.UserName + Environment.MachineName).GetHashCode().ToString();
            _telemetry.Context.Device.Model = vsVersion;
            _telemetry.Context.Device.OperatingSystem = Environment.OSVersion.Version.ToString();
            _telemetry.InstrumentationKey = telemetryKey;
            _telemetry.Context.Component.Version = version;

            //_events = dte.Events.DTEEvents;
            //_events.OnBeginShutdown += delegate { _telemetry.Flush(); };

            Enabled = true;
        }

        private static bool Enabled { get; set; }

        /// <summary>Tracks an event to ApplicationInsights.</summary>
        public static void TrackEvent(string key)
        {
#if !DEBUG
            if (Enabled)
            {
                _telemetry.TrackEvent(key);
            }
#endif
        }

        public static void TrackPageView(string key)
        {
#if !DEBUG
            if (Enabled)
            {
                _telemetry.TrackPageView(key);
            }
#endif
        }

        /// <summary>Tracks any exception.</summary>
        public static void TrackException(Exception ex)
        {
#if !DEBUG
            if (Enabled)
            {
                var telex = new Microsoft.ApplicationInsights.DataContracts.ExceptionTelemetry(ex);
                telex.HandledAt = Microsoft.ApplicationInsights.DataContracts.ExceptionHandledAt.UserCode;
                _telemetry.TrackException(telex);
                _telemetry.Flush();
            }
#endif
        }
    }
}
