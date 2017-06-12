using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Foundation;
using UIKit;
using Security;

namespace TalkingWall.iOS
{
	public class LoginStore : ILoginStore
	{
		private const String SERVERADDRESS = "particle.io";
		private SecRecord record;

		public LoginStore()
		{
			String username = NSUserDefaults.StandardUserDefaults.StringForKey("Username");

			record = new SecRecord (SecKind.InternetPassword){
				Server = SERVERADDRESS,
				Account = username
			};
		}

		private SecRecord getCurrentPassword()
		{
			SecStatusCode response;
			var match = SecKeyChain.QueryAsRecord(record, out response);

			if(response == SecStatusCode.Success)
			{
				return match;
			}

			return null;
		}

		private String getPassword()
		{
			var data = getCurrentPassword();

			return data?.ValueData?.ToString();
		}

		public bool HasLogin
		{
			get
			{
				return !String.IsNullOrWhiteSpace(getPassword());
			}
		}

		public Tuple<string, string> GetLoginInfo()
		{
			return new Tuple<string, string>(
				NSUserDefaults.StandardUserDefaults.StringForKey("Username"),
				NSUserDefaults.StandardUserDefaults.StringForKey("Password")
				);
		}

		public void SaveLogin(string username, string password)
		{
			NSUserDefaults.StandardUserDefaults.SetString(username, "Username");

			var current = getCurrentPassword();
			if(current == null)
			{
				current = new SecRecord(SecKind.InternetPassword)
				{
					Label = "Talking Wall",
					Description = "Authentication Info for Talking Wall",
					Account = username,
					ValueData = password
				};

				var error = SecKeyChain.Add(current);
				if(error != SecStatusCode.Success)
				{
					Console.WriteLine("Error adding record: {0}", error);
				e}
			}
			else
			{
				var update = new SecRecord(SecKind.InternetPassword)
				{
					Account = username,
					ValueData = password
				};
				var error = SecKeyChain.Update(record, update);
				if(error != SecStatusCode.Success)
				{
					Console.WriteLine("Error updating record: {0}", error);
				}
			}
		}
	}
}