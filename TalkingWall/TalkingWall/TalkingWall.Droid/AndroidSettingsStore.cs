using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Android.App;
using Android.Content;
using Android.OS;
using Android.Runtime;
using Android.Views;
using Android.Widget;

namespace TalkingWall.Droid
{
	public class AndroidSettingsStore : ISettingsStore
	{
		protected readonly String ApplicationId = "TalkingWall";
		public string DeviceId
		{
			get
			{
				using (var prefs = Application.Context.GetSharedPreferences(ApplicationId, FileCreationMode.Private))
				{
					return prefs.GetString(nameof(DeviceId), String.Empty);
				}
			}

			set
			{
				using (var prefs = Application.Context.GetSharedPreferences(ApplicationId, FileCreationMode.Private))
				{
					using (var edit = prefs.Edit())
					{
						edit.PutString(nameof(DeviceId), value);
						edit.Commit();
					}
				}
			}
		}
	}
}