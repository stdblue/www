<%@ Page Language="C#" MasterPageFile="enlightened.master" Title="Mail Form" %>

<script runat="server">

    void Page_Load(object sender, EventArgs e)
    {
        
    }

    void btnClear_Click(object sender, EventArgs e)
    {
        this.textSubj.Text = "";
        this.textBody.Text = "";
    }

    void btnSend_Click(object sender, EventArgs e)
    {
    	if ( textAddr.Text.Trim().Length == 0 ) {
    		return;
    	}
    	if ( textSubj.Text.Trim().Length == 0 ) {
    		return;
    	}
    	if ( textBody.Text.Trim().Length == 0 ) {
    		return;
    	}
        System.Web.Mail.SmtpMail.SmtpServer = "smtp5.winserver.ne.jp";
        System.Web.Mail.MailMessage msg = new System.Web.Mail.MailMessage();
        msg.BodyFormat	= System.Web.Mail.MailFormat.Text;
        msg.BodyEncoding	= System.Text.Encoding.UTF8;
        msg.From	= textAddr.Text.Trim();
        msg.To		= "veneficus@stdblue.net";
        msg.Subject	= string.Format("[From Mail Form] {0}", textSubj.Text.Trim());
        msg.Body	= string.Format("名前 : {0}\n表題 : {1}\n\n{2}", textName.Text.Trim(), textSubj.Text.Trim(), textBody.Text.Trim());
        System.Web.Mail.SmtpMail.Send(msg);
        
        pnlMailField.Visible = false;
        
        Label result = new Label();
        result.Text = "メールを送信しました。";
        PlaceContent.Controls.Add(result);
        
        HyperLink link = new HyperLink();
        link.Text = "インデックスに戻ります。";
        link.NavigateUrl = "/vene/IndexPage.aspx";
        PlaceContent.Controls.Add(link);
    }
</script>

<asp:Content ID="ContentMailTo" ContentPlaceHolderID="cphContBase" Runat="Server">
<h2>啓発済み、おてまみフォーム </h2>
<br />
<div class="abstract">
ここからうぇねふぃくす宛にメールを出すことができます。<br />
感想や、要望、何らかのご用件がおありでしたら、ここからどうぞ。<br />
いたずらは勘弁ね。<br />
</div>
<br />
<hr />
<br />
<form id="FormVeneMail" runat="server">
    <asp:PlaceHolder id="PlaceContent" runat="server"></asp:PlaceHolder>
    <asp:Panel id="pnlMailField" runat="server">
    <p>
        <asp:Table id="tblMailForm" runat="server" Width="400px" Height="220px">
            <asp:TableRow ID="name_field">
                <asp:TableCell Width="120px" Text="お名前 ： " ID="name_label"></asp:TableCell>
                <asp:TableCell ID="name_text">
                  <asp:TextBox runat="server" Width="260px" ID="textName"></asp:TextBox>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="address_field">
                <asp:TableCell Width="120px" Text="メール ： " ID="address_label"></asp:TableCell>
                <asp:TableCell ID="addr_text">
                    <asp:TextBox runat="server" Width="260px" ID="textAddr"></asp:TextBox>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="subject_field">
                <asp:TableCell Width="120px" Text="表題 ： " ID="subj_label"></asp:TableCell>
                <asp:TableCell ID="subj_text">
                    <asp:TextBox runat="server" Width="260px" ID="textSubj"></asp:TextBox>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="body_field">
                <asp:TableCell ID="body_text" ColumnSpan="2">
                <asp:TextBox runat="server" Width="380px" TextMode="MultiLine" Rows="10" ID="textBody"></asp:TextBox>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </p>
    <p>
        <asp:Button id="btnSend" runat="server" Width="60px" Text="送信" OnClick="btnSend_Click"></asp:Button>
        <asp:Button id="btnClear" runat="server" Width="60px" Text="クリア" OnClick="btnClear_Click"></asp:Button>
    </p>
    </asp:Panel>
</form>
</asp:Content>

