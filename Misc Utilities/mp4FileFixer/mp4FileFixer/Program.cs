using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Text.RegularExpressions;
using System.Diagnostics;
using System.Threading;

namespace mp4FileFixer
{
	class Program
	{
		public static Regex regex = new Regex(
	  "((?<season>\\d{1,2})?_(?<episode>\\d{1,3})(?<name>.*)|(?<epi" +
	  "sode>\\d{1,3})(?<name>.*)|(?<show>.*)s(?<season>\\d{1,2})?e(" +
	  "?<episode>\\d{1,3})\\s*-\\s*(?<name>.*))\\.(?<ext>.{1,3})",
	RegexOptions.CultureInvariant
	| RegexOptions.Compiled
	);
		static void Main(string[] args)
		{
			var arguments = new Sannel.Arguments(args);
			var show = (arguments.HasArgument("showname")) ? arguments.ArgumentValue("showname") : "";
			var subFolder = (arguments.HasArgument("outdir")) ? arguments.ArgumentValue("outdir") : null;
			String folderName = arguments.NonArgumentValues.FirstOrDefault();
			if (folderName == null)
			{
				folderName = Environment.CurrentDirectory;
			}

			DirectoryInfo folder = new DirectoryInfo(folderName);
			if (!folder.Exists)
			{
				Console.Error.WriteLine($"The directory {folder.FullName} does not exist.");
			}
			else
			{
				ProcessDirectory(folder, subFolder, show);
			}
		}

		static void ProcessDirectory(DirectoryInfo di, String subFolder, String show)
		{
			foreach(var dir in di.GetDirectories())
			{
				if(String.Compare(dir.Name, subFolder, true) != 0)
				{
					ProcessDirectory(dir, subFolder, show);
				}
			}

			Environment.CurrentDirectory = di.FullName;
			if (!String.IsNullOrWhiteSpace(subFolder))
			{
				if(!Directory.Exists(subFolder))
				{
					Directory.CreateDirectory(subFolder);
				}
			}

			foreach (var file in di.GetFiles())
			{
				if (String.Compare(file.Extension, ".mp4", true) == 0 || String.Compare(file.Extension, ".m4v", true) == 0)
				{
					Console.WriteLine($"Begin Processing file {file.Name}");
					var match = regex.Match(file.Name);
					if (match.Success)
					{
						var sg = match.Groups["season"];
						int season = 1;
						if (sg.Success)
						{
							season = Convert.ToInt32(sg.Value);
						}

						int episode = Convert.ToInt32(match.Groups["episode"].Value);
						var name = match.Groups["name"].Value;
						string nfn;
						if (!String.IsNullOrWhiteSpace(show))
						{
							nfn = $"{show} - s{season:00}e{episode:00} - {name?.Trim()}{file.Extension}";
						}
						else
						{
							nfn = $"s{season:00}e{episode:00} - {name?.Trim()}{file.Extension}";
						}
						if (!String.IsNullOrWhiteSpace(subFolder))
						{
							nfn = Path.Combine(subFolder, nfn);
						}

						ProcessStartInfo psi = new ProcessStartInfo("AtomicParsley", $"\"{file.Name}\" -o \"{nfn}\" --artwork REMOVE_ALL --artist \"\" --title \"\" --album \"\" --genre \"\" --tracknum \"\" --disk \"\" --comment \"\" --year \"\" --lyrics \"\" --composer \"\" --copyright \"\" --stik \"\" --description \"\" --Rating \"\" --longdesc \"\" --storedesc \"\" --TVNetwork \"\" --TVShowName \"\" --TVEpisode \"\" --TVSeasonNum \"\" --TVEpisodeNum \"\" --category \"\" --keyword \"\"");
						psi.CreateNoWindow = false;
						psi.UseShellExecute = false;
						var p = Process.Start(psi);
						while (!p.HasExited)
						{
							Thread.Sleep(500);
						}

						Console.WriteLine("\tFinished processing");
					}
					else
					{
						Console.Write("Unable to match with regex");
					}
					Console.WriteLine($"End Processing file {file.Name}");
				}
			}
		}
	}
}
