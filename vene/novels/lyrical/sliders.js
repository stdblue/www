// スライダー機能を実装したJavaScript
// フォントサイズを制御します。

// Font Size
var fs = 12;

function getCookie(key)
{
	var arr = document.cookie.split(";");
	var i;
	for ( i=0; i<arr.length; i++ )
	{
		var pair = arr[i].split("=");
		if ( pair.length > 1 )
		{
			var name = pair[0].replace(/^\s*/gim, "").replace(/\s*$/gim, "");
			if ( name == key )
			{
				return pair[1].replace(/^\s*/gim, "").replace(/\s*$/gim, "");
			}
		}
	}
	return "";
}

function setCookie(key, val)
{
	var d = new Date();
	d.setMonth( d.getMonth() + 1 );
	document.cookie = key + "=" + val + ";expires=" + d.toUTCString() + ";";
}

function resurrect()
{
	var fsize = getCookie('FontSize');
	if ( fsize != "" )
	{
		fs = fsize;

		setPosition(fs * 20);
	}
}

function move(e)
{ 
	var x = e.pageX;
	if(!x) x = e.clientX;
	
	setPosition(x);
}

function setPosition(pos)
{
	var t = document.getElementById('textarea');
	var d = document.getElementById('slider');
	
	fs = pos / 20;
	fs = ( fs < 8 ) ? 8 : Math.floor(fs);
	t.style.fontSize = fs + 'pt';
	pos = ( pos > 80 ) ? pos - 80 : 0;
	d.style.left  = pos + 'px';
}

function restore(e)
{
	setCookie('FontSize', fs);
}
