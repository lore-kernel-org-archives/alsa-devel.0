From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Intel HDA on Mac Pro
Date: Thu, 07 Dec 2006 06:51:40 -0800
Message-ID: <1165503100.7530.19.camel@razman>
References: <4574866D.5070506@sourcegear.com>
	<1165265511.32312.86.camel@razman>	<45748CF5.8040800@sourcegear.com>
	<1165275957.32312.103.camel@razman>	<4574BB17.1020807@sourcegear.com>
	<1165278602.32312.110.camel@razman> <4574EF72.8020207@sourcegear.com>
	<457828D7.4020908@teamprise.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0909109818=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <457828D7.4020908@teamprise.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Shaw Terwilliger <sterwill@teamprise.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============0909109818==
Content-Type: multipart/alternative; boundary="=-drm6KAgpCJo0dfB6f8de"


--=-drm6KAgpCJo0dfB6f8de
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Sorry, I got a bit backlogged.

I just downloaded the codec spec for the 885, and will start going
through it today.  I should have something for you today or tomorrow at
the latest.  Since 1.0.14 is now imminent, I need to get cracking on
several fronts and I want to get support for your system and others in
before 1.0.14 final.

Tobin

On Thu, 2006-12-07 at 08:44 -0600, Shaw Terwilliger wrote:

> Shaw Terwilliger wrote:
> >> This is actually good info.  Interesting that sound is coming out from
> >> the Surround channels.  The low volume could mean that EAPD still needs
> >> to be set.
> >>
> >> I'll look more into this tomorrow.  Hopefully I can get a patch for you
> >> to test.
> > 
> > Thanks for all your help.  I'm happy to test any patches you come up with.
> 
> Have you had a chance too cook up any patches for the Mac Pro HDA
> hardware?  I fooled around with different models yesterday, and the
> "auto" model detects very few output channels (PCM, Front, Line-in), but
> correctly assigns the front channel.  It's still incredibly quiet.
> 

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-drm6KAgpCJo0dfB6f8de
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
Sorry, I got a bit backlogged.<BR>
<BR>
I just downloaded the codec spec for the 885, and will start going through it today.&nbsp; I should have something for you today or tomorrow at the latest.&nbsp; Since 1.0.14 is now imminent, I need to get cracking on several fronts and I want to get support for your system and others in before 1.0.14 final.<BR>
<BR>
Tobin<BR>
<BR>
On Thu, 2006-12-07 at 08:44 -0600, Shaw Terwilliger wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Shaw Terwilliger wrote:</FONT>
<FONT COLOR="#000000">&gt;&gt; This is actually good info.  Interesting that sound is coming out from</FONT>
<FONT COLOR="#000000">&gt;&gt; the Surround channels.  The low volume could mean that EAPD still needs</FONT>
<FONT COLOR="#000000">&gt;&gt; to be set.</FONT>
<FONT COLOR="#000000">&gt;&gt;</FONT>
<FONT COLOR="#000000">&gt;&gt; I'll look more into this tomorrow.  Hopefully I can get a patch for you</FONT>
<FONT COLOR="#000000">&gt;&gt; to test.</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; Thanks for all your help.  I'm happy to test any patches you come up with.</FONT>

<FONT COLOR="#000000">Have you had a chance too cook up any patches for the Mac Pro HDA</FONT>
<FONT COLOR="#000000">hardware?  I fooled around with different models yesterday, and the</FONT>
<FONT COLOR="#000000">&quot;auto&quot; model detects very few output channels (PCM, Front, Line-in), but</FONT>
<FONT COLOR="#000000">correctly assigns the front channel.  It's still incredibly quiet.</FONT>

</PRE>
</BLOCKQUOTE>
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

--=-drm6KAgpCJo0dfB6f8de--



--===============0909109818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0909109818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0909109818==--
