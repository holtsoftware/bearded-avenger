using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Xamarin.Forms;

namespace TalkingWall
{
	public class App : Application
	{
		public App (ILoginStore store, ISettingsStore setting)
		{
			// The root page of your application
			MainPage = new StartPage(store, setting);
		}

		protected override void OnStart ()
		{
			// Handle when your app starts
		}

		protected override void OnSleep ()
		{
			// Handle when your app sleeps
		}

		protected override void OnResume ()
		{
			// Handle when your app resumes
		}
	}
}
