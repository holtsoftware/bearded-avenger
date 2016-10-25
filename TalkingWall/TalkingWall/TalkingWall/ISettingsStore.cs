using System;
using System.Collections.Generic;
using System.Text;

namespace TalkingWall
{
	public interface ISettingsStore
	{
		String DeviceId
		{
			get;
			set;
		}
	}
}
