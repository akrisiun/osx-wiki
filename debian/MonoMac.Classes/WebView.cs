using MonoMac.AppKit;
using MonoMac.Foundation;
using MonoMac.ObjCRuntime;
using System;
using System.ComponentModel;
using System.Drawing;
using System.Runtime.CompilerServices;

namespace MonoMac.WebKit
{
	[Register ("WebView", true)]
	public class WebView : NSView
	{
		//
		// Static Properties
		//
		[CompilerGenerated]
		public static string[] MimeTypesShownAsHtml {
			[Export ("MIMETypesShownAsHTML")]
			get;
			[Export ("setMIMETypesShownAsHTML:")]
			set;
		}

		//
		// Properties
		//
		[CompilerGenerated]
		public virtual string ApplicationNameForUserAgent {
			[Export ("applicationNameForUserAgent")]
			get;
			[Export ("setApplicationNameForUserAgent:")]
			set;
		}

		[CompilerGenerated]
		public virtual WebBackForwardList BackForwardList {
			[Export ("backForwardList")]
			get;
		}

		public override IntPtr ClassHandle {
			get;
		}

		[CompilerGenerated]
		public virtual bool ContinuousSpellCheckingEnabled {
			[Export ("isContinuousSpellCheckingEnabled")]
			get;
			[Export ("setContinuousSpellCheckingEnabled:")]
			set;
		}

		[CompilerGenerated]
		public virtual string CustomTextEncodingName {
			[Export ("customTextEncodingName")]
			get;
			[Export ("setCustomTextEncodingName:")]
			set;
		}

		[CompilerGenerated]
		public virtual string CustomUserAgent {
			[Export ("customUserAgent")]
			get;
			[Export ("setCustomUserAgent:")]
			set;
		}

		[CompilerGenerated]
		public WebDownloadDelegate DownloadDelegate {
			get;
			set;
		}

		[CompilerGenerated]
		public virtual bool DrawsBackground {
			[Export ("drawsBackground")]
			get;
			[Export ("setDrawsBackground:")]
			set;
		}

		[CompilerGenerated]
		public virtual bool Editable {
			[Export ("isEditable")]
			get;
			[Export ("setEditable:")]
			set;
		}

		[CompilerGenerated]
		public virtual NSObject EditingDelegate {
			[Export ("editingDelegate")]
			get;
			[Export ("setEditingDelegate:")]
			set;
		}

		[CompilerGenerated]
		public virtual double EstimatedProgress {
			[Export ("estimatedProgress")]
			get;
		}

		[CompilerGenerated]
		public WebFrameLoadDelegate FrameLoadDelegate {
			get;
			set;
		}

		[CompilerGenerated]
		public virtual string GroupName {
			[Export ("groupName")]
			get;
			[Export ("setGroupName:")]
			set;
		}

		[CompilerGenerated]
		public virtual NSWindow HostWindow {
			[Export ("hostWindow")]
			get;
			[Export ("setHostWindow:")]
			set;
		}

		[CompilerGenerated]
		public virtual bool IsLoading {
			[Export ("isLoading")]
			get;
		}

		[CompilerGenerated]
		public virtual WebFrame MainFrame {
			[Export ("mainFrame")]
			get;
		}

		[CompilerGenerated]
		public virtual DomDocument MainFrameDocument {
			[Export ("mainFrameDocument")]
			get;
		}

		[CompilerGenerated]
		public virtual NSImage MainFrameIcon {
			[Export ("mainFrameIcon")]
			get;
		}

		[CompilerGenerated]
		public virtual string MainFrameTitle {
			[Export ("mainFrameTitle")]
			get;
		}

		[CompilerGenerated]
		public virtual string MainFrameUrl {
			[Export ("mainFrameURL")]
			get;
			[Export ("setMainFrameURL:")]
			set;
		}

		[CompilerGenerated]
		public virtual bool MaintainsInactiveSelection {
			[Export ("maintainsInactiveSelection")]
			get;
		}

		[CompilerGenerated]
		public virtual string MediaStyle {
			[Export ("mediaStyle")]
			get;
			[Export ("setMediaStyle:")]
			set;
		}

		public WebDownloadRequest OnDownloadWindowForSheet {
			get;
			set;
		}

		public WebResourceIdentifierRequest OnIdentifierForInitialRequest {
			get;
			set;
		}

		public WebResourceOnRequestSend OnSendRequest {
			get;
			set;
		}

		[CompilerGenerated]
		public virtual NSPasteboard[] PasteboardTypesForSelection {
			[Export ("pasteboardTypesForSelection")]
			get;
		}

		[CompilerGenerated]
		public WebPolicyDelegate PolicyDelegate {
			get;
			set;
		}

		[CompilerGenerated]
		public virtual WebPreferences Preferences {
			[Export ("preferences")]
			get;
			[Export ("setPreferences:")]
			set;
		}

		[CompilerGenerated]
		public virtual string PreferencesIdentifier {
			[Export ("preferencesIdentifier")]
			get;
			[Export ("setPreferencesIdentifier:")]
			set;
		}

		[CompilerGenerated]
		public WebResourceLoadDelegate ResourceLoadDelegate {
			get;
			set;
		}

		[CompilerGenerated]
		public virtual DomRange SelectedDomRange {
			[Export ("selectedDOMRange")]
			get;
		}

		[CompilerGenerated]
		public virtual WebFrame SelectedFrame {
			[Export ("selectedFrame")]
			get;
		}

		[CompilerGenerated]
		public virtual NSSelectionAffinity SelectionAffinity {
			[Export ("selectionAffinity")]
			get;
		}

		[CompilerGenerated]
		public virtual bool ShouldCloseWithWindow {
			[Export ("shouldCloseWithWindow")]
			get;
			[Export ("setShouldCloseWithWindow:")]
			set;
		}

		[CompilerGenerated]
		public virtual bool SmartInsertDeleteEnabled {
			[Export ("smartInsertDeleteEnabled")]
			get;
			[Export ("setSmartInsertDeleteEnabled:")]
			set;
		}

		[CompilerGenerated]
		public virtual int SpellCheckerDocumentTag {
			[Export ("spellCheckerDocumentTag")]
			get;
		}

		[CompilerGenerated]
		public virtual bool SupportsTextEncoding {
			[Export ("supportsTextEncoding")]
			get;
		}

		[CompilerGenerated]
		public virtual float TextSizeMultiplier {
			[Export ("textSizeMultiplier")]
			get;
			[Export ("setTextSizeMultiplier:")]
			set;
		}

		[CompilerGenerated]
		public virtual DomCssStyleDeclaration TypingStyle {
			[Export ("typingStyle")]
			get;
			[Export ("setTypingStyle:")]
			set;
		}

		public WebViewGetBool UIAreToolbarsVisible {
			get;
			set;
		}

		public WebViewCreate UICreateModalDialog {
			get;
			set;
		}

		public CreateWebViewFromRequest UICreateWebView {
			get;
			set;
		}

		[CompilerGenerated]
		public WebUIDelegate UIDelegate {
			get;
			set;
		}

		public DragSourceGetActionMask UIDragSourceActionMask {
			get;
			set;
		}

		public WebViewGetRectangle UIGetContentRect {
			get;
			set;
		}

		public WebViewGetContextMenuItems UIGetContextMenuItems {
			get;
			set;
		}

		public DragDestinationGetActionMask UIGetDragDestinationActionMask {
			get;
			set;
		}

		public WebViewGetResponder UIGetFirstResponder {
			get;
			set;
		}

		public WebViewGetFloat UIGetFooterHeight {
			get;
			set;
		}

		public WebViewGetRectangle UIGetFrame {
			get;
			set;
		}

		public WebViewGetFloat UIGetHeaderHeight {
			get;
			set;
		}

		public WebViewGetString UIGetStatusText {
			get;
			set;
		}

		public WebViewGetBool UIIsResizable {
			get;
			set;
		}

		public WebViewGetBool UIIsStatusBarVisible {
			get;
			set;
		}

		public WebViewJavaScriptFrame UIRunBeforeUnload {
			get;
			set;
		}

		public WebViewConfirmationPanel UIRunJavaScriptConfirmationPanel {
			get;
			set;
		}

		public WebViewPrompt UIRunJavaScriptConfirmPanel {
			get;
			set;
		}

		public WebViewJavaScriptInput UIRunJavaScriptTextInputPanel {
			get;
			set;
		}

		public WebViewPromptPanel UIRunJavaScriptTextInputPanelWithFrame {
			get;
			set;
		}

		public WebViewPerformAction UIShouldPerformActionfromSender {
			get;
			set;
		}

		public WebViewValidateUserInterface UIValidateUserInterfaceItem {
			get;
			set;
		}

		[CompilerGenerated]
		public virtual NSUndoManager UndoManager {
			[Export ("undoManager")]
			get;
		}

		[CompilerGenerated]
		public virtual bool UpdateWhileOffscreen {
			[Export ("shouldUpdateWhileOffscreen")]
			get;
			[Export ("setShouldUpdateWhileOffscreen:")]
			set;
		}

		[CompilerGenerated]
		public virtual NSObject WeakDownloadDelegate {
			[Export ("downloadDelegate")]
			get;
			[Export ("setDownloadDelegate:")]
			set;
		}

		[CompilerGenerated]
		public virtual NSObject WeakFrameLoadDelegate {
			[Export ("frameLoadDelegate")]
			get;
			[Export ("setFrameLoadDelegate:")]
			set;
		}

		[CompilerGenerated]
		public virtual NSObject WeakPolicyDelegate {
			[Export ("policyDelegate")]
			get;
			[Export ("setPolicyDelegate:")]
			set;
		}

		[CompilerGenerated]
		public virtual NSObject WeakResourceLoadDelegate {
			[Export ("resourceLoadDelegate")]
			get;
			[Export ("setResourceLoadDelegate:")]
			set;
		}

		[CompilerGenerated]
		public virtual NSObject WeakUIDelegate {
			[Export ("UIDelegate")]
			get;
			[Export ("setUIDelegate:")]
			set;
		}

		[CompilerGenerated]
		public virtual WebScriptObject WindowScriptObject {
			[Export ("windowScriptObject")]
			get;
		}

		//
		// Constructors
		//
		[EditorBrowsable (EditorBrowsableState.Advanced), CompilerGenerated]
		public WebView (IntPtr handle);

		[Export ("init"), EditorBrowsable (EditorBrowsableState.Advanced), CompilerGenerated]
		public WebView ();

		[Export ("initWithCoder:"), EditorBrowsable (EditorBrowsableState.Advanced), CompilerGenerated]
		public WebView (NSCoder coder);

		[EditorBrowsable (EditorBrowsableState.Advanced), CompilerGenerated]
		public WebView (NSObjectFlag t);

		[Export ("initWithFrame:frameName:groupName:"), CompilerGenerated]
		public WebView (RectangleF frame, string frameName, string groupName);

		//
		// Static Methods
		//
		[Export ("canShowMIMEType:"), CompilerGenerated]
		public static bool CanShowMimeType (string MimeType);

		[Export ("canShowMIMETypeAsHTML:"), CompilerGenerated]
		public static bool CanShowMimeTypeAsHtml (string mimeType);

		public static void DecideDownload (NSObject decisionToken);

		public static void DecideIgnore (NSObject decisionToken);

		public static void DecideUse (NSObject decisionToken);

		[Export ("registerURLSchemeAsLocal:"), CompilerGenerated]
		public static void RegisterUrlSchemeAsLocal (string scheme);

		[Export ("registerViewClass:representationClass:forMIMEType:"), CompilerGenerated]
		public static void RegisterViewClass (Class viewClass, Class representationClass, string mimeType);

		[Export ("URLFromPasteboard:"), CompilerGenerated]
		public static NSUrl UrlFromPasteboard (NSPasteboard pasteboard);

		[Export ("URLTitleFromPasteboard:"), CompilerGenerated]
		public static string UrlTitleFromPasteboard (NSPasteboard pasteboard);

		//
		// Methods
		//
		[Export ("alignCenter:"), CompilerGenerated]
		public virtual void AlignCenter (NSObject sender);

		[Export ("alignJustified:"), CompilerGenerated]
		public virtual void AlignJustified (NSObject sender);

		[Export ("alignLeft:"), CompilerGenerated]
		public virtual void AlignLeft (NSObject sender);

		[Export ("alignRight:"), CompilerGenerated]
		public virtual void AlignRight (NSObject sender);

		[Export ("applyStyle:"), CompilerGenerated]
		public virtual void ApplyStyle (DomCssStyleDeclaration style);

		[Export ("canGoBack"), CompilerGenerated]
		public virtual bool CanGoBack ();

		[Export ("canGoForward"), CompilerGenerated]
		public virtual bool CanGoForward ();

		[Export ("canMakeTextLarger"), CompilerGenerated]
		public virtual bool CanMakeTextLarger ();

		[Export ("canMakeTextSmaller"), CompilerGenerated]
		public virtual bool CanMakeTextSmaller ();

		[Export ("canMakeTextStandardSize"), CompilerGenerated]
		public virtual bool CanMakeTextStandardSize ();

		[Export ("changeAttributes:"), CompilerGenerated]
		public virtual void ChangeAttributes (NSObject sender);

		[Export ("changeColor:"), CompilerGenerated]
		public virtual void ChangeColor (NSObject sender);

		[Export ("changeDocumentBackgroundColor:"), CompilerGenerated]
		public virtual void ChangeDocumentBackgroundColor (NSObject sender);

		[Export ("changeFont:"), CompilerGenerated]
		public virtual void ChangeFont (NSObject sender);

		[Export ("checkSpelling:"), CompilerGenerated]
		public virtual void CheckSpelling (NSObject sender);

		[Export ("close"), CompilerGenerated]
		public virtual void Close ();

		[Export ("copyFont:"), CompilerGenerated]
		public virtual void CopyFont (NSObject sender);

		[Export ("cut:"), CompilerGenerated]
		public virtual void Cut (NSObject sender);

		[Export ("delete:"), CompilerGenerated]
		public virtual void Delete (NSObject sender);

		[Export ("deleteSelection"), CompilerGenerated]
		public virtual void DeleteSelection ();

		[CompilerGenerated]
		protected override void Dispose (bool disposing);

		[Export ("elementAtPoint:"), CompilerGenerated]
		public virtual NSDictionary ElementAtPoint (PointF point);

		private WebView._WebDownloadDelegate EnsureWebDownloadDelegate ();

		private WebView._WebFrameLoadDelegate EnsureWebFrameLoadDelegate ();

		private WebView._WebPolicyDelegate EnsureWebPolicyDelegate ();

		private WebView._WebResourceLoadDelegate EnsureWebResourceLoadDelegate ();

		private WebView._WebUIDelegate EnsureWebUIDelegate ();

		[Export ("goBack"), CompilerGenerated]
		public virtual bool GoBack ();

		[Export ("goForward"), CompilerGenerated]
		public virtual bool GoForward ();

		[Export ("goToBackForwardItem:"), CompilerGenerated]
		public virtual bool GoToBackForwardItem (WebHistoryItem item);

		[Export ("makeTextLarger:"), CompilerGenerated]
		public virtual void MakeTextLarger (NSObject sender);

		[Export ("makeTextSmaller:"), CompilerGenerated]
		public virtual void MakeTextSmaller (NSObject sender);

		[Export ("makeTextStandardSize:"), CompilerGenerated]
		public virtual void MakeTextStandardSize (NSObject sender);

		[Export ("moveDragCaretToPoint:"), CompilerGenerated]
		public virtual void MoveDragCaretToPoint (PointF point);

		[Export ("moveToBeginningOfSentence:"), CompilerGenerated]
		public virtual void MoveToBeginningOfSentence (NSObject sender);

		[Export ("moveToBeginningOfSentenceAndModifySelection:"), CompilerGenerated]
		public virtual void MoveToBeginningOfSentenceAndModifySelection (NSObject sender);

		[Export ("moveToEndOfSentence:"), CompilerGenerated]
		public virtual void MoveToEndOfSentence (NSObject sender);

		[Export ("moveToEndOfSentenceAndModifySelection:"), CompilerGenerated]
		public virtual void MoveToEndOfSentenceAndModifySelection (NSObject sender);

		[Export ("paste:"), CompilerGenerated]
		public virtual void Paste (NSObject sender);

		[Export ("pasteAsPlainText:"), CompilerGenerated]
		public virtual void PasteAsPlainText (NSObject sender);

		[Export ("pasteAsRichText:"), CompilerGenerated]
		public virtual void PasteAsRichText (NSObject sender);

		[Export ("pasteboardTypesForElement:"), CompilerGenerated]
		public virtual NSObject[] PasteboardTypesForElement (NSDictionary element);

		[Export ("pasteFont:"), CompilerGenerated]
		public virtual void PasteFont (NSObject sender);

		[Export ("performFindPanelAction:"), CompilerGenerated]
		public virtual void PerformFindPanelAction (NSObject sender);

		[Export ("reload:"), CompilerGenerated]
		public virtual void Reload (NSObject sender);

		[Export ("reloadFromOrigin:"), CompilerGenerated]
		public virtual void ReloadFromOrigin (NSObject sender);

		[Export ("removeDragCaret"), CompilerGenerated]
		public virtual void RemoveDragCaret ();

		[Export ("replaceSelectionWithArchive:"), CompilerGenerated]
		public virtual void ReplaceSelectionWithArchive (WebArchive archive);

		[Export ("replaceSelectionWithMarkupString:"), CompilerGenerated]
		public virtual void ReplaceSelectionWithMarkupString (string markupString);

		[Export ("searchFor:direction:caseSensitive:wrap:"), CompilerGenerated]
		public virtual bool Search (string forString, bool forward, bool caseSensitive, bool wrap);

		[Export ("selectSentence:"), CompilerGenerated]
		public virtual void SelectSentence (NSObject sender);

		[Export ("setMaintainsBackForwardList:"), CompilerGenerated]
		public virtual void SetMaintainsBackForwardList (bool flag);

		[Export ("showGuessPanel:"), CompilerGenerated]
		public virtual void ShowGuessPanel (NSObject sender);

		[Export ("startSpeaking:"), CompilerGenerated]
		public virtual void StartSpeaking (NSObject sender);

		[Export ("stopSpeaking:"), CompilerGenerated]
		public virtual void StopSpeaking (NSObject sender);

		[Export ("stringByEvaluatingJavaScriptFromString:"), CompilerGenerated]
		public virtual string StringByEvaluatingJavaScriptFromString (string script);

		[Export ("styleDeclarationWithText:"), CompilerGenerated]
		public virtual DomCssStyleDeclaration StyleDeclarationWithText (string text);

		[Export ("toggleContinuousSpellChecking:"), CompilerGenerated]
		public virtual void ToggleContinuousSpellChecking (NSObject sender);

		[Export ("toggleSmartInsertDelete:"), CompilerGenerated]
		public virtual void ToggleSmartInsertDelete (NSObject sender);

		[Export ("userAgentForURL:"), CompilerGenerated]
		public virtual string UserAgentForUrl (NSUrl url);

		[Export ("writeElement:withPasteboardTypes:toPasteboard:"), CompilerGenerated]
		public virtual void WriteElement (NSDictionary element, NSObject[] pasteboardTypes, NSPasteboard toPasteboard);

		[Export ("writeSelectionWithPasteboardTypes:toPasteboard:"), CompilerGenerated]
		public virtual void WriteSelection (NSObject[] types, NSPasteboard pasteboard);

		//
		// Events
		//
		public event EventHandler<WebFrameEventArgs> CanceledClientRedirect {
			add;
			remove;
		}

		public event EventHandler<WebFrameEventArgs> ChangedLocationWithinPage {
			add;
			remove;
		}

		public event EventHandler<WebFrameScriptFrameEventArgs> ClearedWindowObject {
			add;
			remove;
		}

		public event EventHandler<WebFrameEventArgs> CommitedLoad {
			add;
			remove;
		}

		public event EventHandler<WebMimeTypePolicyEventArgs> DecidePolicyForMimeType {
			add;
			remove;
		}

		public event EventHandler<WebNavigationPolicyEventArgs> DecidePolicyForNavigation {
			add;
			remove;
		}

		public event EventHandler<WebNewWindowPolicyEventArgs> DecidePolicyForNewWindow {
			add;
			remove;
		}

		public event EventHandler<WebFrameErrorEventArgs> FailedLoadWithError {
			add;
			remove;
		}

		public event EventHandler<WebFrameErrorEventArgs> FailedProvisionalLoad {
			add;
			remove;
		}

		public event EventHandler<WebFrameEventArgs> FinishedLoad {
			add;
			remove;
		}

		public event EventHandler<WebResourceCancelledChallengeEventArgs> OnCancelledAuthenticationChallenge {
			add;
			remove;
		}

		public event EventHandler<WebResourceErrorEventArgs> OnFailedLoading {
			add;
			remove;
		}

		public event EventHandler<WebResourceCompletedEventArgs> OnFinishedLoading {
			add;
			remove;
		}

		public event EventHandler<WebResourcePluginErrorEventArgs> OnPlugInFailed {
			add;
			remove;
		}

		public event EventHandler<WebResourceAuthenticationChallengeEventArgs> OnReceivedAuthenticationChallenge {
			add;
			remove;
		}

		public event EventHandler<WebResourceReceivedContentLengthEventArgs> OnReceivedContentLength {
			add;
			remove;
		}

		public event EventHandler<WebResourceReceivedResponseEventArgs> OnReceivedResponse {
			add;
			remove;
		}

		public event EventHandler<WebFrameImageEventArgs> ReceivedIcon {
			add;
			remove;
		}

		public event EventHandler<WebFrameEventArgs> ReceivedServerRedirectForProvisionalLoad {
			add;
			remove;
		}

		public event EventHandler<WebFrameTitleEventArgs> ReceivedTitle {
			add;
			remove;
		}

		public event EventHandler<WebFrameEventArgs> StartedProvisionalLoad {
			add;
			remove;
		}

		public event EventHandler UIClose {
			add;
			remove;
		}

		public event EventHandler<WebViewFooterEventArgs> UIDrawFooterInRect {
			add;
			remove;
		}

		public event EventHandler<WebViewHeaderEventArgs> UIDrawHeaderInRect {
			add;
			remove;
		}

		public event EventHandler UIFocus {
			add;
			remove;
		}

		public event EventHandler<WebViewResponderEventArgs> UIMakeFirstResponder {
			add;
			remove;
		}

		public event EventHandler<WebViewMouseMovedEventArgs> UIMouseDidMoveOverElement {
			add;
			remove;
		}

		public event EventHandler<WebViewPrintEventArgs> UIPrintFrameView {
			add;
			remove;
		}

		public event EventHandler<WebViewJavaScriptEventArgs> UIRunJavaScriptAlertPanel {
			add;
			remove;
		}

		public event EventHandler<WebViewJavaScriptFrameEventArgs> UIRunJavaScriptAlertPanelMessage {
			add;
			remove;
		}

		public event EventHandler UIRunModal {
			add;
			remove;
		}

		public event EventHandler<WebViewRunOpenPanelEventArgs> UIRunOpenPanelForFileButton {
			add;
			remove;
		}

		public event EventHandler<WebViewContentEventArgs> UISetContentRect {
			add;
			remove;
		}

		public event EventHandler<WebViewFrameEventArgs> UISetFrame {
			add;
			remove;
		}

		public event EventHandler<WebViewResizableEventArgs> UISetResizable {
			add;
			remove;
		}

		public event EventHandler<WebViewStatusBarEventArgs> UISetStatusBarVisible {
			add;
			remove;
		}

		public event EventHandler<WebViewStatusTextEventArgs> UISetStatusText {
			add;
			remove;
		}

		public event EventHandler<WebViewToolBarsEventArgs> UISetToolbarsVisible {
			add;
			remove;
		}

		public event EventHandler UIShow {
			add;
			remove;
		}

		public event EventHandler UIUnfocus {
			add;
			remove;
		}

		public event EventHandler<WebViewDragEventArgs> UIWillPerformDragDestination {
			add;
			remove;
		}

		public event EventHandler<WebViewPerformDragEventArgs> UIWillPerformDragSource {
			add;
			remove;
		}

		public event EventHandler<WebFailureToImplementPolicyEventArgs> UnableToImplementPolicy {
			add;
			remove;
		}

		public event EventHandler<WebFrameEventArgs> WillCloseFrame {
			add;
			remove;
		}

		public event EventHandler<WebFrameClientRedirectEventArgs> WillPerformClientRedirect {
			add;
			remove;
		}

		public event EventHandler<WebFrameScriptObjectEventArgs> WindowScriptObjectAvailable {
			add;
			remove;
		}

		//
		// Nested Types
		//
		[Register]
		private sealed class _WebDownloadDelegate : WebDownloadDelegate
		{
			public _WebDownloadDelegate ();

			[Preserve (Conditional = true)]
			public override NSWindow OnDownloadWindowForSheet (WebDownload download);
		}

		[Register]
		private sealed class _WebFrameLoadDelegate : WebFrameLoadDelegate
		{
			public _WebFrameLoadDelegate ();

			[Preserve (Conditional = true)]
			public override void StartedProvisionalLoad (WebView sender, WebFrame forFrame);

			[Preserve (Conditional = true)]
			public override void ReceivedServerRedirectForProvisionalLoad (WebView sender, WebFrame forFrame);

			[Preserve (Conditional = true)]
			public override void FailedProvisionalLoad (WebView sender, NSError error, WebFrame forFrame);

			[Preserve (Conditional = true)]
			public override void CommitedLoad (WebView sender, WebFrame forFrame);

			[Preserve (Conditional = true)]
			public override void ReceivedTitle (WebView sender, string title, WebFrame forFrame);

			[Preserve (Conditional = true)]
			public override void ReceivedIcon (WebView sender, NSImage image, WebFrame forFrame);

			[Preserve (Conditional = true)]
			public override void FinishedLoad (WebView sender, WebFrame forFrame);

			[Preserve (Conditional = true)]
			public override void FailedLoadWithError (WebView sender, NSError error, WebFrame forFrame);

			[Preserve (Conditional = true)]
			public override void ChangedLocationWithinPage (WebView sender, WebFrame forFrame);

			[Preserve (Conditional = true)]
			public override void WillPerformClientRedirect (WebView sender, NSUrl toUrl, double secondsDelay, NSDate fireDate, WebFrame forFrame);

			[Preserve (Conditional = true)]
			public override void CanceledClientRedirect (WebView sender, WebFrame forFrame);

			[Preserve (Conditional = true)]
			public override void WillCloseFrame (WebView sender, WebFrame forFrame);

			[Preserve (Conditional = true)]
			public override void ClearedWindowObject (WebView webView, WebScriptObject windowObject, WebFrame forFrame);

			[Preserve (Conditional = true)]
			public override void WindowScriptObjectAvailable (WebView webView, WebScriptObject windowScriptObject);
		}

		[Register]
		private sealed class _WebPolicyDelegate : WebPolicyDelegate
		{
			public _WebPolicyDelegate ();

			[Preserve (Conditional = true)]
			public override void DecidePolicyForNavigation (WebView webView, NSDictionary actionInformation, NSUrlRequest request, WebFrame frame, NSObject decisionToken);

			[Preserve (Conditional = true)]
			public override void DecidePolicyForNewWindow (WebView webView, NSDictionary actionInformation, NSUrlRequest request, string newFrameName, NSObject decisionToken);

			[Preserve (Conditional = true)]
			public override void DecidePolicyForMimeType (WebView webView, string mimeType, NSUrlRequest request, WebFrame frame, NSObject decisionToken);

			[Preserve (Conditional = true)]
			public override void UnableToImplementPolicy (WebView webView, NSError error, WebFrame frame);
		}

		[Register]
		private sealed class _WebResourceLoadDelegate : WebResourceLoadDelegate
		{
			public _WebResourceLoadDelegate ();

			[Preserve (Conditional = true)]
			public override NSObject OnIdentifierForInitialRequest (WebView sender, NSUrlRequest request, WebDataSource dataSource);

			[Preserve (Conditional = true)]
			public override NSUrlRequest OnSendRequest (WebView sender, NSObject identifier, NSUrlRequest request, NSUrlResponse redirectResponse, WebDataSource dataSource);

			[Preserve (Conditional = true)]
			public override void OnReceivedAuthenticationChallenge (WebView sender, NSObject identifier, NSUrlAuthenticationChallenge challenge, WebDataSource dataSource);

			[Preserve (Conditional = true)]
			public override void OnCancelledAuthenticationChallenge (WebView sender, NSObject identifier, NSUrlAuthenticationChallenge challenge, WebDataSource dataSource);

			[Preserve (Conditional = true)]
			public override void OnReceivedResponse (WebView sender, NSObject identifier, NSUrlResponse responseReceived, WebDataSource dataSource);

			[Preserve (Conditional = true)]
			public override void OnReceivedContentLength (WebView sender, NSObject identifier, int length, WebDataSource dataSource);

			[Preserve (Conditional = true)]
			public override void OnFinishedLoading (WebView sender, NSObject identifier, WebDataSource dataSource);

			[Preserve (Conditional = true)]
			public override void OnFailedLoading (WebView sender, NSObject identifier, NSError withError, WebDataSource dataSource);

			[Preserve (Conditional = true)]
			public override void OnPlugInFailed (WebView sender, NSError error, WebDataSource dataSource);
		}

		[Register]
		private sealed class _WebUIDelegate : WebUIDelegate
		{
			public _WebUIDelegate ();

			[Preserve (Conditional = true)]
			public override WebView UICreateWebView (WebView sender, NSUrlRequest request);

			[Preserve (Conditional = true)]
			public override void UIShow (WebView sender);

			[Preserve (Conditional = true)]
			public override WebView UICreateModalDialog (WebView sender, NSUrlRequest request);

			[Preserve (Conditional = true)]
			public override void UIRunModal (WebView sender);

			[Preserve (Conditional = true)]
			public override void UIClose (WebView sender);

			[Preserve (Conditional = true)]
			public override void UIFocus (WebView sender);

			[Preserve (Conditional = true)]
			public override void UIUnfocus (WebView sender);

			[Preserve (Conditional = true)]
			public override NSResponder UIGetFirstResponder (WebView sender);

			[Preserve (Conditional = true)]
			public override void UIMakeFirstResponder (WebView sender, NSResponder newResponder);

			[Preserve (Conditional = true)]
			public override void UISetStatusText (WebView sender, string text);

			[Preserve (Conditional = true)]
			public override string UIGetStatusText (WebView sender);

			[Preserve (Conditional = true)]
			public override bool UIAreToolbarsVisible (WebView sender);

			[Preserve (Conditional = true)]
			public override void UISetToolbarsVisible (WebView sender, bool visible);

			[Preserve (Conditional = true)]
			public override bool UIIsStatusBarVisible (WebView sender);

			[Preserve (Conditional = true)]
			public override void UISetStatusBarVisible (WebView sender, bool visible);

			[Preserve (Conditional = true)]
			public override bool UIIsResizable (WebView sender);

			[Preserve (Conditional = true)]
			public override void UISetResizable (WebView sender, bool resizable);

			[Preserve (Conditional = true)]
			public override void UISetFrame (WebView sender, RectangleF newFrame);

			[Preserve (Conditional = true)]
			public override RectangleF UIGetFrame (WebView sender);

			[Preserve (Conditional = true)]
			public override void UIRunJavaScriptAlertPanelMessage (WebView sender, string withMessage, WebFrame initiatedByFrame);

			[Preserve (Conditional = true)]
			public override bool UIRunJavaScriptConfirmationPanel (WebView sender, string withMessage, WebFrame initiatedByFrame);

			[Preserve (Conditional = true)]
			public override string UIRunJavaScriptTextInputPanelWithFrame (WebView sender, string prompt, string defaultText, WebFrame initiatedByFrame);

			[Preserve (Conditional = true)]
			public override bool UIRunBeforeUnload (WebView sender, string message, WebFrame initiatedByFrame);

			[Preserve (Conditional = true)]
			public override void UIRunOpenPanelForFileButton (WebView sender, WebOpenPanelResultListener resultListener);

			[Preserve (Conditional = true)]
			public override void UIMouseDidMoveOverElement (WebView sender, NSDictionary elementInformation, NSEventModifierMask modifierFlags);

			[Preserve (Conditional = true)]
			public override NSMenuItem[] UIGetContextMenuItems (WebView sender, NSDictionary forElement, NSMenuItem[] defaultMenuItems);

			[Preserve (Conditional = true)]
			public override bool UIValidateUserInterfaceItem (WebView webView, NSObject validatedUserInterfaceItem, bool defaultValidation);

			[Preserve (Conditional = true)]
			public override bool UIShouldPerformActionfromSender (WebView webView, Selector action, NSObject sender);

			[Preserve (Conditional = true)]
			public override NSEventModifierMask UIGetDragDestinationActionMask (WebView webView, NSDraggingInfo draggingInfo);

			[Preserve (Conditional = true)]
			public override void UIWillPerformDragDestination (WebView webView, WebDragDestinationAction action, NSDraggingInfo draggingInfo);

			[Preserve (Conditional = true)]
			public override NSEventModifierMask UIDragSourceActionMask (WebView webView, PointF point);

			[Preserve (Conditional = true)]
			public override void UIWillPerformDragSource (WebView webView, WebDragSourceAction action, PointF sourcePoint, NSPasteboard pasteboard);

			[Preserve (Conditional = true)]
			public override void UIPrintFrameView (WebView sender, WebFrameView frameView);

			[Preserve (Conditional = true)]
			public override float UIGetHeaderHeight (WebView sender);

			[Preserve (Conditional = true)]
			public override float UIGetFooterHeight (WebView sender);

			[Preserve (Conditional = true)]
			public override void UIDrawHeaderInRect (WebView sender, RectangleF rect);

			[Preserve (Conditional = true)]
			public override void UIDrawFooterInRect (WebView sender, RectangleF rect);

			[Preserve (Conditional = true)]
			public override void UIRunJavaScriptAlertPanel (WebView sender, string message);

			[Preserve (Conditional = true)]
			public override bool UIRunJavaScriptConfirmPanel (WebView sender, string message);

			[Preserve (Conditional = true)]
			public override string UIRunJavaScriptTextInputPanel (WebView sender, string prompt, string defaultText);

			[Preserve (Conditional = true)]
			public override void UISetContentRect (WebView sender, RectangleF frame);

			[Preserve (Conditional = true)]
			public override RectangleF UIGetContentRect (WebView sender);
		}
	}
}
