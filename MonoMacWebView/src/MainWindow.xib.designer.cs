// WARNING
//
// This file has been generated automatically by Xamarin Studio to store outlets and
// actions made in the UI designer. If it is removed, they will be lost.
// Manual changes to this file may not be handled correctly.
//
using MonoMac.Foundation;
// using System.CodeDom.Compiler;

namespace WhereIsMyMac
{
	[Register ("MainWindowController")]
	partial class MainWindowController
	{
		[Outlet]
		MonoMac.WebKit.WebView webView { get; set; }

		[Action ("openInDefaultBrowser:")]
		partial void openInDefaultBrowser (MonoMac.AppKit.NSButton sender);
		
		void ReleaseDesignerOutlets ()
		{
			if (webView != null) {
				webView.Dispose ();
				webView = null;
			}
		}
	}

	[Register ("MainWindow")]
	partial class MainWindow
	{
		
		void ReleaseDesignerOutlets ()
		{
		}
	}
}
