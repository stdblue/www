<%@ Page Language="C#" %>
<%@ import Namespace="System.Xml" %>
<script runat="server">

    void Page_Load(object sender, EventArgs e)
    {
        Response.Redirect("/vene/Default.aspx");
    }

</script>
<?xml version="1.0" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<?xml-stylesheet href="/vene/css/illuminated.css" type="text/css" ?>
<html lang="ja" xml:lang="ja" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>啓発済み：おひっこし、おひっこし～</title>
    <link href="/vene/css/illuminated.css" type="text/css" rel="stylesheet" />

    <style type="text/css">
    .header
    {
        font-size: 12px;
        font-weight: bold;
        background-color: aliceblue;
    }
    
    .explain
    {
    	font-size: 12px;
        color: aliceblue;
    }

    .reporting
    {
		position: absolute;
		top: 60px;	left: 10%;
		width: 600px; height: 400px;
    }

	#field {
	}
    </style>

</head>
<body>
  <div style="HEIGHT: 54px; font-size:large;">啓発済み？<br />
    ブックマークなどの変更をお願いいたします。<br />
  </div>
  <br />
  <div align="right">
  管理者 : うぇねふぃくす 
  </div>
  <br />
</body>
</html>
