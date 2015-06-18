// Monomac GUI tutorial
// https://www.alexwhittemore.com/my-first-monomac-gui/


using MonoMac.Foundation;
using System;
using System.ComponentModel;
using System.Drawing;
using System.Runtime.CompilerServices;

namespace MonoMac.AppKit
{
	[Register ("NSButton", true)]
	public class NSButton : NSControl
	{
		//
		// Properties
		//
		[CompilerGenerated]
		public virtual bool AllowsMixedState {
			[Export ("allowsMixedState")]
			get;
			[Export ("setAllowsMixedState:")]
			set;
		}

		[CompilerGenerated]
		public virtual NSImage AlternateImage {
			[Export ("alternateImage")]
			get;
			[Export ("setAlternateImage:")]
			set;
		}

		[CompilerGenerated]
		public virtual string AlternateTitle {
			[Export ("alternateTitle")]
			get;
			[Export ("setAlternateTitle:")]
			set;
		}

		[CompilerGenerated]
		public virtual NSAttributedString AttributedAlternateTitle {
			[Export ("attributedAlternateTitle")]
			get;
			[Export ("setAttributedAlternateTitle:")]
			set;
		}

		[CompilerGenerated]
		public virtual NSAttributedString AttributedTitle {
			[Export ("attributedTitle")]
			get;
			[Export ("setAttributedTitle:")]
			set;
		}

		[CompilerGenerated]
		public virtual NSBezelStyle BezelStyle {
			[Export ("bezelStyle")]
			get;
			[Export ("setBezelStyle:")]
			set;
		}

		[CompilerGenerated]
		public virtual bool Bordered {
			[Export ("isBordered")]
			get;
			[Export ("setBordered:")]
			set;
		}

		public new NSButtonCell Cell {
			get;
			set;
		}

		public override IntPtr ClassHandle {
			get;
		}

		[CompilerGenerated]
		public virtual NSImage Image {
			[Export ("image")]
			get;
			[Export ("setImage:")]
			set;
		}

		[CompilerGenerated]
		public virtual NSCellImagePosition ImagePosition {
			[Export ("imagePosition")]
			get;
			[Export ("setImagePosition:")]
			set;
		}

		[CompilerGenerated]
		public virtual string KeyEquivalent {
			[Export ("keyEquivalent")]
			get;
			[Export ("setKeyEquivalent:")]
			set;
		}

		[CompilerGenerated]
		public virtual NSEventModifierMask KeyEquivalentModifierMask {
			[Export ("keyEquivalentModifierMask")]
			get;
			[Export ("setKeyEquivalentModifierMask:")]
			set;
		}

		[CompilerGenerated]
		public virtual NSSound Sound {
			[Export ("sound")]
			get;
			[Export ("setSound:")]
			set;
		}

		[CompilerGenerated]
		public virtual NSCellStateValue State {
			[Export ("state")]
			get;
			[Export ("setState:")]
			set;
		}

		[CompilerGenerated]
		public virtual string Title {
			[Export ("title")]
			get;
			[Export ("setTitle:")]
			set;
		}

		[CompilerGenerated]
		public virtual bool Transparent {
			[Export ("isTransparent")]
			get;
			[Export ("setTransparent:")]
			set;
		}

		//
		// Constructors
		//
		[Export ("initWithFrame:"), CompilerGenerated]
		public NSButton (RectangleF frameRect);

		[EditorBrowsable (EditorBrowsableState.Advanced), CompilerGenerated]
		public NSButton (IntPtr handle);

		[EditorBrowsable (EditorBrowsableState.Advanced), CompilerGenerated]
		public NSButton (NSObjectFlag t);

		[Export ("initWithCoder:"), EditorBrowsable (EditorBrowsableState.Advanced), CompilerGenerated]
		public NSButton (NSCoder coder);

		[Export ("init"), EditorBrowsable (EditorBrowsableState.Advanced), CompilerGenerated]
		public NSButton ();

		//
		// Methods
		//
		[CompilerGenerated]
		protected override void Dispose (bool disposing);

		[Export ("getPeriodicDelay:interval:"), CompilerGenerated]
		public virtual void GetPeriodicDelay (ref float delay, ref float interval);

		[Export ("highlight:"), CompilerGenerated]
		public virtual void Highlight (bool flag);

		[Export ("performKeyEquivalent:"), CompilerGenerated]
		public new virtual bool PerformKeyEquivalent (NSEvent key);

		[Export ("setButtonType:"), CompilerGenerated]
		public virtual void SetButtonType (NSButtonType aType);

		[Export ("setNextState"), CompilerGenerated]
		public virtual void SetNextState ();

		[Export ("setPeriodicDelay:interval:"), CompilerGenerated]
		public virtual void SetPeriodicDelay (float delay, float interval);

		[Export ("setTitleWithMnemonic:"), CompilerGenerated]
		public virtual void SetTitleWithMnemonic (string mnemonic);

		[Export ("showsBorderOnlyWhileMouseInside"), CompilerGenerated]
		public virtual bool ShowsBorderOnlyWhileMouseInside ();
	}
}
