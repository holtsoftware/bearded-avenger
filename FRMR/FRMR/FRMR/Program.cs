using Sannel;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;

namespace FRMR
{
	class Program
	{
		public static Regex fileRegEx = new Regex("(?<Season>\\d+)_(?<Episode>\\d+)\\s(?<Name>.+)", RegexOptions.CultureInvariant | RegexOptions.Compiled);

		static void Main(string[] args)
		{
			Arguments arguments = new Arguments(args);
			
			if(!String.IsNullOrWhiteSpace(arguments.ArgumentValue("show")))
			{
				if (arguments.HasArgument("fixtitle") || arguments.HasArgument("removeartwork"))
				{
					RenameMatchesWithAP(arguments.ArgumentValue("show"), arguments.HasArgument("fixtitle"), arguments.HasArgument("removeartwork"));
				}
				else
				{
					RenameMatches(arguments.ArgumentValue("show"));
				}
			}
			else
			{
				Console.Error.WriteLine("You must provide --Show");
			}
		}

		static void RenameMatches(String showName)
		{
			Console.WriteLine("RenameMatches");
			DirectoryInfo di = new DirectoryInfo(Environment.CurrentDirectory);
			foreach(var file in di.GetFiles())
			{
				var match = fileRegEx.Match(file.Name);
				if (match.Groups["Season"].Success && match.Groups["Episode"].Success && match.Groups["Name"].Success)
				{
					Console.WriteLine("Fixing file {0}", file.Name);
					file.MoveTo(String.Format("{0} - s{1:00}e{2:00} - {3}", showName, int.Parse(match.Groups["Season"].Value), int.Parse(match.Groups["Episode"].Value), match.Groups["Name"].Value));
				}
			}
		}

		static void RenameMatchesWithAP(String showName, bool fixTitle, bool removeArtwork)
		{
			Console.WriteLine("RenameMatchesWithAP");
			DirectoryInfo di = new DirectoryInfo(Environment.CurrentDirectory);
			foreach (var file in di.GetFiles())
			{
				var match = fileRegEx.Match(file.Name);
				if (match.Groups["Season"].Success && match.Groups["Episode"].Success && match.Groups["Name"].Success)
				{
					Console.WriteLine("Fixing file {0}", file.Name);
					if(String.Compare(file.Extension, ".mp4", true) == 0 || String.Compare(file.Extension, ".m4v", true) == 0)
					{
						file.MoveTo("tmp.tmp");

						StringBuilder args = new StringBuilder();
						args.AppendFormat("\"{0}\" ", file.Name);
						if(fixTitle)
						{
							var name = match.Groups["Name"].Value;
							name = name.Substring(0, name.Length - file.Extension.Length);
							args.AppendFormat("--title \"{0}\" ", name);
						}
						if(removeArtwork)
						{
							args.Append("--artwork REMOVE_ALL ");
						}

						args.AppendFormat("-o \"{0}\" ", String.Format("{0} - s{1:00}e{2:00} - {3}", showName, int.Parse(match.Groups["Season"].Value), int.Parse(match.Groups["Episode"].Value), match.Groups["Name"].Value));

						ProcessStartInfo spi = new ProcessStartInfo("AtomicParsley");
						spi.Arguments = args.ToString();
						spi.WorkingDirectory = Environment.CurrentDirectory;
						var p = Process.Start(spi);
						while(!p.HasExited)
						{
							Thread.Sleep(50);
						}

						file.Delete();
						
					}
					else
					{
						file.MoveTo(String.Format("{0} - s{1:00}e{2:00} - {3}", showName, int.Parse(match.Groups["Season"].Value), int.Parse(match.Groups["Episode"].Value), match.Groups["Name"].Value));
					}
				}
			}
		}
	}
}
