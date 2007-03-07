From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: [ibm-acpi-devel] Adding a alsa mixer interface
	to	ibm-acpi
Date: Wed, 07 Mar 2007 15:23:54 -0800
Message-ID: <1173309834.4531.22.camel@razman.gruemaster.com>
References: <20070225012017.GA19039@khazad-dum.debian.net>
	<s5h649pue8z.wl%tiwai@suse.de>
	<20070226162819.GE2909@khazad-dum.debian.net>
	<s5hr6scswnp.wl%tiwai@suse.de>
	<20070226174145.GF2909@khazad-dum.debian.net>
	<20070227015024.GF8154@thunk.org>
	<20070227021402.GC6828@khazad-dum.debian.net>
	<s5hd53kaf5r.wl%tiwai@suse.de>
	<41840b750703071512o1d171dfy9d2a615382e5e635@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1433980848=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <41840b750703071512o1d171dfy9d2a615382e5e635@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Shem Multinymous <multinymous@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ibm-acpi-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net, Theodore Tso <tytso@mit.edu>
List-Id: alsa-devel@alsa-project.org


--===============1433980848==
Content-Type: multipart/alternative; boundary="=-mJmxk6MwARq1lL+vcC9G"


--=-mJmxk6MwARq1lL+vcC9G
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2007-03-07 at 18:12 -0500, Shem Multinymous wrote:

> 
> The ibm-acpi mixer also affects the BIOS-generated sounds (e.g.,
> low-battery warnings) and PC speaker. So it useful even when the sound
> card is unused or unsupported.
> 

Don't those sounds go through the beep generator?  Most codecs use a
beep generator for system sounds, that routes through the codec.

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-mJmxk6MwARq1lL+vcC9G
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
On Wed, 2007-03-07 at 18:12 -0500, Shem Multinymous wrote:<BR>
<BLOCKQUOTE TYPE=CITE>
    <BR>
    <TT><FONT COLOR="#000000">The ibm-acpi mixer also affects the BIOS-generated sounds (e.g.,</FONT></TT><BR>
    <TT><FONT COLOR="#000000">low-battery warnings) and PC speaker. So it useful even when the sound</FONT></TT><BR>
    <TT><FONT COLOR="#000000">card is unused or unsupported.</FONT></TT><BR>
    <BR>
</BLOCKQUOTE>
Don't those sounds go through the beep generator?&nbsp; Most codecs use a beep generator for system sounds, that routes through the codec.<BR>
<BR>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
-- <BR>
Tobin Davis &lt;<A HREF="mailto:tdavis@dsl-only.net">tdavis@dsl-only.net</A>&gt;
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-mJmxk6MwARq1lL+vcC9G--



--===============1433980848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1433980848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1433980848==--
