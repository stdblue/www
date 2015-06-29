<%@ Page Language="C#" MasterPageFile="enlightened.master" Title="啓発済み？" %>

<%@ import Namespace="System.Xml" %>
<script runat="server">

    void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            XmlDocument doc = new XmlDocument();
            doc.Load(Server.MapPath("./historica.xml"));
            XmlNodeList nlist = doc.SelectNodes("/history/list/term");
            int num = (nlist.Count > 5 ) ? 5 : nlist.Count;
            if ( num > 0 ) {
                Table tbl = new Table();
                tbl.ToolTip = "更新履歴 : 最新５件を表示しています。";

                TableRow header_row = new TableRow();
                
                TableHeaderCell header_date = new TableHeaderCell();
                header_date.Text = "更新日時";
                header_row.Cells.Add(header_date);
                
                TableHeaderCell header_content = new TableHeaderCell();
                header_content.Text = "更新内容";
                header_row.Cells.Add(header_content);
                
                tbl.Rows.Add(header_row);
                
                for ( int i=0; i<num; i++ ) {
                    XmlElement elem = nlist[i] as XmlElement;
                    if ( elem != null ) {
                        string str_date = elem.SelectSingleNode("date").InnerText;
                        string str_content = elem.SelectSingleNode("content").InnerText;
                        XmlElement place = elem.SelectSingleNode("place") as XmlElement;
                        TableRow row = new TableRow();
                        TableCell cell_date = new TableCell();
                        cell_date.Text = str_date;
                        cell_date.CssClass = "last";
                        TableCell cell_cont = new TableCell();
                        if (place == null)
                        {
                            cell_cont.Text = str_content;
                        }
                        else
                        {
                            string refer = place.Attributes.GetNamedItem("href").Value;
                            HyperLink refer_place = new HyperLink();
                            refer_place.Text = str_content;
                            refer_place.ToolTip = place.InnerText;
                            refer_place.NavigateUrl = refer;
                            cell_cont.Controls.Add(refer_place);
                        }
                        cell_cont.CssClass = "last";
                        row.Cells.Add(cell_date);
                        row.Cells.Add(cell_cont);
                        tbl.Rows.Add(row);
                    }
                }
                this.HistoricalPlace.Controls.Add(tbl);
           }
        }
    }

</script>
<asp:Content ID="ContentTop" ContentPlaceHolderID="cphContBase" Runat="Server">
<!--shinobi1-->
<script type="text/javascript" src="http://x5.turigane.com/ufo/047414900"></script>
<noscript><a href="http://x5.turigane.com/bin/gg?047414900" target="_blank">
<img src="http://x5.turigane.com/bin/ll?047414900" border="0"></a><br>
<span style="font-size:9px">[PR] <a href="http://human-jobs.rental-rental.net" target="_blank">人材紹介</a></span></noscript>
<!--shinobi2-->

<div style="margin-top:100px;"></div>
<h1 style="text-align:right;">啓発済み？</h1>
<br />
<h2 title="更新履歴">Last update</h2>
<p class="top">
<asp:PlaceHolder ID="HistoricalPlace" Runat="Server" />
</p>

<h2>Site について</h2>
<p class="top">
このサイトはうぇねふぃくすが管理する個人サイトです。<br />
全ての文章に対する責任はヽ(ﾟ∀｡)ﾉうぇねにあります。<br />
<br />
このサイトのリンクはご自由にどうぞ。<br />
ブックマークやアンテナへの登録はここにお願いします。<br />
</p>

</asp:Content>

