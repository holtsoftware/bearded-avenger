using Foundation;
using System;
using System.Collections.Generic;
using System.Text;

namespace TalkingWall.iOS
{
	public class SettingsStore : ISettingsStore
	{
		public string DeviceId
		{
			get => NSUserDefaults.StandardUserDefaults.StringForKey(nameof(DeviceId));
			set => NSUserDefaults.StandardUserDefaults.SetString(value, nameof(DeviceId));
		}
	}
}
