using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;

namespace TalkingWall
{
	public partial class StartPage : ContentPage
	{
		private ILoginStore store;
		private ISettingsStore setting;

		public StartPage (ILoginStore store, ISettingsStore setting)
		{
			this.store = store;
			this.setting = setting;
			InitializeComponent ();
			BindingContext = this;

			if (store.HasLogin)
			{
				var data = store.GetLoginInfo();
				Username = data.Item1;
				Password = data.Item2;
				OnPropertyChanged(nameof(Username));
				OnPropertyChanged(nameof(Password));
			}

			DeviceId = setting.DeviceId;
			OnPropertyChanged(nameof(DeviceId));
		}

		public String Username { get; set; }
		public String Password { get; set; }
		public String DeviceId { get; set; }
		private String message;
		public String Message
		{
			get
			{
				return message;
			}
			set
			{
				if (message != value)
				{
					message = value;
					OnPropertyChanged(nameof(Message));
				}
			}
		}

		private bool isBusy = false;
		public bool LocalIsBusy
		{
			get
			{
				return isBusy;
			}
			set
			{
				if(isBusy != value)
				{
					isBusy = value;
					OnPropertyChanged(nameof(LocalIsBusy));
				}
			}
		}

		private async void buttonClicked(object sender, EventArgs e)
		{
			LocalIsBusy = true;
			using(var cloud = new Particle.ParticleCloud())
			{
				var result = await cloud.LoginWithUserAsync(Username, Password);
				if (result.Success)
				{
					store.SaveLogin(Username, Password);
					var devices = await cloud.GetDevicesAsync();
					if (devices.Success)
					{
						var first = devices.Data.FirstOrDefault(i => String.Compare(i.Id, DeviceId) == 0);
						if(first != null)
						{
							setting.DeviceId = first.Id;

							var fixedMessage = String.Empty;
							foreach(var c in message.ToLower())
							{
								if(c >= 'a' && c <= 'z' || c == ' ')
								{
									fixedMessage += c;
								}
							}
							Message = fixedMessage;
							var ret = await first.CallFunctionAsync("message", fixedMessage);
							if (ret.Success)
							{
								await DisplayAlert("Success", "Message sent", "Ok");
								LocalIsBusy = false;
								return;
							}
						}
						else
						{
							await DisplayAlert("Error", "Device Not found", "Ok");
							LocalIsBusy = false;
							return;
						}
					}
				}
				await DisplayAlert("Error", "Unable to send message", "Ok");
				LocalIsBusy = false;
			}
		}
	}
}
