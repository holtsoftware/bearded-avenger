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
using Xamarin.Auth;

namespace TalkingWall.Droid
{
	public class AndroidLoginStore : ILoginStore
	{
		private Context context;
		private readonly String id = "TalkingWall";

		public AndroidLoginStore(Context context)
		{
			this.context = context;
		}

		public bool HasLogin
		{
			get
			{
				return AccountStore.Create(context).FindAccountsForService(id).Count() > 0;
			}
		}

		public Tuple<String, String> GetLoginInfo()
		{
			var last = AccountStore.Create(context).FindAccountsForService(id).FirstOrDefault();
			if (last != null)
			{
				return new Tuple<string, string>(last.Username, last.Properties["Key"]);
			}

			return new Tuple<string, string>("", "");
		}

		public void SaveLogin(string username, string password)
		{
			if (!String.IsNullOrWhiteSpace(username) && !String.IsNullOrWhiteSpace(password))
			{
				Account user = new Account { Username = username };
				user.Properties.Add("Key", password);
				AccountStore.Create(context).Save(user, id);
			}
		}
	}
}