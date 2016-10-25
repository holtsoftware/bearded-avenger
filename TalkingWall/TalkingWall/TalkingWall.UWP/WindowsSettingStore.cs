using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using Windows.Storage;

namespace TalkingWall.UWP
{
	public class WindowsSettingStore : ISettingsStore
	{
		private ApplicationDataContainer settings;

		public WindowsSettingStore()
		{
			settings = ApplicationData.Current.RoamingSettings;
		}
		private String getString([CallerMemberName]String key = null, String def = null)
		{
			String s = settings.Values[key] as String;
			if (s != null)
			{
				return s;
			}

			return def;
		}

		private void setString(String value, [CallerMemberName]String key = null)
		{
			if (value == null)
			{
				settings.Values[key] = null;
			}
			else
			{
				settings.Values[key] = value;
			}
		}

		public string DeviceId
		{
			get
			{
				return getString(def: String.Empty);
			}

			set
			{
				setString(value);
			}
		}
	}
}
