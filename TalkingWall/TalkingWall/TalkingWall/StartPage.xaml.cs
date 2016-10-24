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
		public StartPage ()
		{
			InitializeComponent ();
			BindingContext = this;
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

		private async void buttonClicked(object sender, EventArgs e)
		{
			using(var cloud = new Particle.ParticleCloud())
			{
				var result = await cloud.LoginWithUserAsync(Username, Password);
				if (result.Success)
				{
					var devices = await cloud.GetDevicesAsync();
					if (devices.Success)
					{
						var first = devices.Data.FirstOrDefault(i => String.Compare(i.Id, DeviceId) == 0);
						if(first != null)
						{
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
								return;
							}
						}
					}
				}
				await DisplayAlert("Error", "Unable to send message", "Ok");
			}
		}
	}
}
