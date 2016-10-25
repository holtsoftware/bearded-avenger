using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using Windows.Security.Credentials;

namespace TalkingWall.UWP
{
	public class WindowsLoginStore : ILoginStore
	{
		private const String RESOURCE = "sannel.com/particle";
		public bool HasLogin
		{
			get
			{
				var passwordValut = new Windows.Security.Credentials.PasswordVault();
				var list = passwordValut.RetrieveAll();
				return list.Where(i => String.Compare(i.Resource, RESOURCE) == 0).Count() > 0;
			}
		}

		public Tuple<string, string> GetLoginInfo()
		{
			var passwordValut = new Windows.Security.Credentials.PasswordVault();
			var list = passwordValut.RetrieveAll();

			var login = list.FirstOrDefault(i => String.Compare(i.Resource, RESOURCE) == 0);
			if (login != null)
			{
				login.RetrievePassword();
				return new Tuple<string, string>(login.UserName, login.Password);
			}
			return new Tuple<string, string>(String.Empty, String.Empty);
		}

		public void SaveLogin(string username, string password)
		{
			PasswordCredential pc;
			var passwordVault = new Windows.Security.Credentials.PasswordVault();
			var list = passwordVault.RetrieveAll().Where(i => String.Compare(i.Resource, RESOURCE) == 0);
			if((pc = list.FirstOrDefault(i => String.Compare(i.UserName, username) == 0)) != null)
			{
				passwordVault.Remove(pc);
				passwordVault.Add(new Windows.Security.Credentials.PasswordCredential(RESOURCE, username, password));
			}
			else if(list.Count() > 0)
			{
				foreach(var p in list)
				{
					passwordVault.Remove(p);
				}
			}
			passwordVault.Add(new Windows.Security.Credentials.PasswordCredential(RESOURCE, username, password));
		}
	}
}
