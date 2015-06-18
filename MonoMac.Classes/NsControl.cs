
using MonoMac.Foundation;
using MonoMac.ObjCRuntime;
using System;
using System.ComponentModel;
using System.Drawing;
using System.Runtime.CompilerServices;

namespace MonoMac.AppKit
{
	[Register ("NSControl", true)]
	public class NSControl : NSView
	{
		//
		// Static Properties
		//
		[CompilerGenerated]
		public static Class CellClass {
			[Export ("cellClass")]
			get;
			[Export ("setCellClass:")]
			set;
		}

		//
		// Properties
		//
		[CompilerGenerated]
		public virtual Selector Action {
			[Export ("action")]
			get;
			[Export ("setAction:")]
			set;
		}

		[CompilerGenerated]
		public virtual NSTextAlignment Alignment {
			[Export ("alignment")]
			get;
			[Export ("setAlignment:")]
			set;
		}

		[CompilerGenerated]
		public virtual NSAttributedString AttributedStringValue {
			[Export ("attributedStringValue")]
			get;
			[Export ("setAttributedStringValue:")]
			set;
		}

		[CompilerGenerated]
		public virtual NSWritingDirection BaseWritingDirection {
			[Export ("baseWritingDirection")]
			get;
			[Export ("setBaseWritingDirection:")]
			set;
		}

		[CompilerGenerated]
		public virtual NSCell Cell {
			[Export ("cell")]
			get;
			[Export ("setCell:")]
			set;
		}

		public override IntPtr ClassHandle {
			get;
		}

		[CompilerGenerated]
		public virtual bool Continuous {
			[Export ("isContinuous")]
			get;
			[Export ("setContinuous:")]
			set;
		}

		[CompilerGenerated]
		public virtual NSText CurrentEditor {
			[Export ("currentEditor")]
			get;
		}

		[CompilerGenerated]
		public virtual double DoubleValue {
			[Export ("doubleValue")]
			get;
			[Export ("setDoubleValue:")]
			set;
		}

		[CompilerGenerated]
		public virtual bool Enabled {
			[Export ("isEnabled")]
			get;
			[Export ("setEnabled:")]
			set;
		}

		[CompilerGenerated]
		public virtual float FloatValue {
			[Export ("floatValue")]
			get;
			[Export ("setFloatValue:")]
			set;
		}

		[CompilerGenerated]
		public virtual NSFont Font {
			[Export ("font")]
			get;
			[Export ("setFont:")]
			set;
		}

		[CompilerGenerated]
		public virtual NSObject Formatter {
			[Export ("formatter")]
			get;
			[Export ("setFormatter:")]
			set;
		}

		[CompilerGenerated]
		public virtual bool IgnoresMultiClick {
			[Export ("ignoresMultiClick")]
			get;
			[Export ("setIgnoresMultiClick:")]
			set;
		}

		[CompilerGenerated]
		public virtual int IntegerValue {
			[Export ("integerValue")]
			get;
			[Export ("setIntegerValue:")]
			set;
		}

		[CompilerGenerated]
		public virtual int IntValue {
			[Export ("intValue")]
			get;
			[Export ("setIntValue:")]
			set;
		}

		[CompilerGenerated]
		public virtual NSObject ObjectValue {
			[Export ("objectValue")]
			get;
			[Export ("setObjectValue:")]
			set;
		}

		[CompilerGenerated]
		public virtual bool RefusesFirstResponder {
			[Export ("refusesFirstResponder")]
			get;
			[Export ("setRefusesFirstResponder:")]
			set;
		}

		[CompilerGenerated]
		public virtual NSCell SelectedCell {
			[Export ("selectedCell")]
			get;
		}

		[CompilerGenerated]
		public virtual int SelectedTag {
			[Export ("selectedTag")]
			get;
		}

		[CompilerGenerated]
		public virtual string StringValue {
			[Export ("stringValue")]
			get;
			[Export ("setStringValue:")]
			set;
		}

		[CompilerGenerated]
		public new virtual int Tag {
			[Export ("tag")]
			get;
			[Export ("setTag:")]
			set;
		}

		[CompilerGenerated]
		public virtual NSObject Target {
			[Export ("target")]
			get;
			[Export ("setTarget:")]
			set;
		}

		//
		// Constructors
		//
		[Export ("initWithFrame:"), CompilerGenerated]
		public NSControl (RectangleF frameRect);

		[EditorBrowsable (EditorBrowsableState.Advanced), CompilerGenerated]
		public NSControl (IntPtr handle);

		[EditorBrowsable (EditorBrowsableState.Advanced), CompilerGenerated]
		public NSControl (NSObjectFlag t);

		[Export ("initWithCoder:"), EditorBrowsable (EditorBrowsableState.Advanced), CompilerGenerated]
		public NSControl (NSCoder coder);

		[Export ("init"), EditorBrowsable (EditorBrowsableState.Advanced), CompilerGenerated]
		public NSControl ();

		//
		// Methods
		//
		[Export ("abortEditing"), CompilerGenerated]
		public virtual bool AbortEditing ();

		[Export ("calcSize"), CompilerGenerated]
		public virtual void CalcSize ();

		[CompilerGenerated]
		protected override void Dispose (bool disposing);

		[Export ("drawCell:"), CompilerGenerated]
		public virtual void DrawCell (NSCell aCell);

		[Export ("drawCellInside:"), CompilerGenerated]
		public virtual void DrawCellInside (NSCell aCell);

		[Export ("invalidateIntrinsicContentSizeForCell:"), CompilerGenerated]
		public virtual void InvalidateIntrinsicContentSizeForCell (NSCell cell);

		[Export ("mouseDown:"), CompilerGenerated]
		public new virtual void MouseDown (NSEvent theEvent);

		[Export ("performClick:"), CompilerGenerated]
		public virtual void PerformClick (NSObject sender);

		[Export ("selectCell:"), CompilerGenerated]
		public virtual void SelectCell (NSCell aCell);

		[Export ("sendAction:to:"), CompilerGenerated]
		public virtual bool SendAction (Selector theAction, NSObject theTarget);

		[Export ("sendActionOn:"), CompilerGenerated]
		public virtual int SendActionOn (NSEventType mask);

		[Export ("setNeedsDisplay"), CompilerGenerated]
		public virtual void SetNeedsDisplay ();

		[Export ("sizeToFit"), CompilerGenerated]
		public virtual void SizeToFit ();

		[Export ("takeDoubleValueFrom:"), CompilerGenerated]
		public virtual void TakeDoubleValueFrom (NSObject sender);

		[Export ("takeFloatValueFrom:"), CompilerGenerated]
		public virtual void TakeFloatValueFrom (NSObject sender);

		[Export ("takeIntegerValueFrom:"), CompilerGenerated]
		public virtual void TakeIntegerValueFrom (NSObject sender);

		[Export ("takeIntValueFrom:"), CompilerGenerated]
		public virtual void TakeIntValueFrom (NSObject sender);

		[Export ("takeObjectValueFrom:"), CompilerGenerated]
		public virtual void TakeObjectValueFrom (NSObject sender);

		[Export ("takeStringValueFrom:"), CompilerGenerated]
		public virtual void TakeStringValueFrom (NSObject sender);

		[Export ("updateCell:"), CompilerGenerated]
		public virtual void UpdateCell (NSCell aCell);

		[Export ("updateCellInside:"), CompilerGenerated]
		public virtual void UpdateCellInside (NSCell aCell);

		[Export ("validateEditing"), CompilerGenerated]
		public virtual void ValidateEditing ();

		//
		// Events
		//
		public event EventHandler Activated {
			add;
			remove;
		}
	}
}

