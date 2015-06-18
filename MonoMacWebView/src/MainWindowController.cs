
using System;
using System.Collections.Generic;
using System.Linq;
using MonoMac.Foundation;
using MonoMac.AppKit;
using MonoMac.CoreLocation;
using MonoMac.WebKit;
using System.IO;

namespace WhereIsMyMac
{
	public partial class MainWindowController : MonoMac.AppKit.NSWindowController {		   

		// Called when created from unmanaged code
		public MainWindowController (IntPtr handle) : base(handle)
		{
		}

		// Called when created directly from a XIB file
		[Export("initWithCoder:")]
		public MainWindowController (NSCoder coder) : base(coder)
		{
		}

		// Call to load from the XIB/NIB file
		public MainWindowController () : base("MainWindow")
		{
		}

		string urlPath = @"http://www.google.com";

		public void SetUrl()
		{
			if (webView != null)
				webView.MainFrameUrl = urlPath;
		}


		public override void AwakeFromNib ()
		{
			SetUrl ();
		}

		void HandleLocationManagerFailed (object sender, MonoMac.Foundation.NSErrorEventArgs e)
		{
			Console.WriteLine ("Failed");
		}
		  
		partial void openInDefaultBrowser (NSButton sender)
		{
			var externalBrowserURL = new NSUrl (urlPath);
			NSWorkspace.SharedWorkspace.OpenUrl (externalBrowserURL);
		}
	}
}

