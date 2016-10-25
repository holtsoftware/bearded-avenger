using System;
using System.Collections.Generic;
using System.Text;

namespace TalkingWall
{
	public interface ILoginStore
	{
		bool HasLogin
		{
			get;
		}

		Tuple<String, String> GetLoginInfo();

		void SaveLogin(String username, String password);
	}
}
