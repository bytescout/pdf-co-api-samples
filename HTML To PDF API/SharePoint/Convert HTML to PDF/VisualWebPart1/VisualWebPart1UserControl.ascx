<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VisualWebPart1UserControl.ascx.cs" Inherits="ConvertWebPageToPDFLinkWebPart.VisualWebPart1.VisualWebPart1UserControl" %>
Page url<br />
<asp:TextBox ID="UrlTextBox" runat="server" Width="600px">http://en.wikipedia.org/wiki/Main_Page</asp:TextBox>
<br />
<br />
<asp:Button ID="StartButton" runat="server" OnClick="StartButton_Click" Text="Start" style="width: 610px; padding-left: 0px; margin-left: 0px; padding-right: 0px; padding-right: 0px;"/>
<br />
<br />
Log<br />
<asp:TextBox ID="LogTextBox" runat="server" Height="300px" TextMode="MultiLine" Width="600px"></asp:TextBox>
<br />