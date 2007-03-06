From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Hello/EMU 0404 USB driver
Date: Tue, 06 Mar 2007 15:21:07 -0800
Message-ID: <1173223267.16119.10.camel@razman.gruemaster.com>
References: <45EDF4C7.30704@bham.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1111689407=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45EDF4C7.30704@bham.ac.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Martin Wilson <mpw473@bham.ac.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1111689407==
Content-Type: multipart/alternative; boundary="=-6qNs095fmmYs/ZuMUq4u"


--=-6qNs095fmmYs/ZuMUq4u
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I'd start by downloading the latest test driver, alsa-driver-1.0.14rc3.
There have been a lot of changes to the usb audio recently.  That would
be a good starting point.

As to developing drivers, I couldn't tell you where to start.  The base
for snd-usb-audio is already in place, I'd look it over an get an idea
how it works, then see about getting specs for your sound device to add
to this base.

Tobin

On Tue, 2007-03-06 at 23:09 +0000, Martin Wilson wrote:

> Hi all,
> 
> I've been using Linux for work related tasks for a couple of years now 
> and after some initial difficulties it has been a great experience.  I 
> now wouldn't dream of going back to a proprietary OS as feel I can work 
> more far efficiently as a result of using open source tools.  I am 
> currently using a mac mini at home for making music attached to a EMU 
> 0404 USB which is a very good card.  I would like to use something like 
> Ubuntu studio instead of OSX for making music, however the sticking 
> point is the driver for this particular piece of hardware.  Looking 
> around forums it looks like I'm not the only one who has come across 
> this problem, so I have the following questions...
> 1. What is the biggest obstacle for this driver becoming a reality?
> 2. Do creative play nicely with releasing the specifics of how their 
> hardware works?
> 3. What is the best way to learn how to write drivers for sound cards 
> (I've ordered the 'Linux Device drivers' book for an overview)?
> 4. Does the fact it is USB make it harder?
> I have experience in programming in c/c++ and would like to have crack 
> at writing a driver (even if I fail miserably!), but I don't want to 
> spend ages leaning this process if it's an impossible task because I 
> can't get the required information from Creative.  I am noticing many 
> exciting tools such as JACK and Ardour gaining momentum and my hope is 
> that soon Linux can be as good for play as it has proven to be for work :)
> 
> Thanks
> 
> Martin
> 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-6qNs095fmmYs/ZuMUq4u
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
I'd start by downloading the latest test driver, alsa-driver-1.0.14rc3.&nbsp; There have been a lot of changes to the usb audio recently.&nbsp; That would be a good starting point.<BR>
<BR>
As to developing drivers, I couldn't tell you where to start.&nbsp; The base for snd-usb-audio is already in place, I'd look it over an get an idea how it works, then see about getting specs for your sound device to add to this base.<BR>
<BR>
Tobin<BR>
<BR>
On Tue, 2007-03-06 at 23:09 +0000, Martin Wilson wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Hi all,</FONT>

<FONT COLOR="#000000">I've been using Linux for work related tasks for a couple of years now </FONT>
<FONT COLOR="#000000">and after some initial difficulties it has been a great experience.  I </FONT>
<FONT COLOR="#000000">now wouldn't dream of going back to a proprietary OS as feel I can work </FONT>
<FONT COLOR="#000000">more far efficiently as a result of using open source tools.  I am </FONT>
<FONT COLOR="#000000">currently using a mac mini at home for making music attached to a EMU </FONT>
<FONT COLOR="#000000">0404 USB which is a very good card.  I would like to use something like </FONT>
<FONT COLOR="#000000">Ubuntu studio instead of OSX for making music, however the sticking </FONT>
<FONT COLOR="#000000">point is the driver for this particular piece of hardware.  Looking </FONT>
<FONT COLOR="#000000">around forums it looks like I'm not the only one who has come across </FONT>
<FONT COLOR="#000000">this problem, so I have the following questions...</FONT>
<FONT COLOR="#000000">1. What is the biggest obstacle for this driver becoming a reality?</FONT>
<FONT COLOR="#000000">2. Do creative play nicely with releasing the specifics of how their </FONT>
<FONT COLOR="#000000">hardware works?</FONT>
<FONT COLOR="#000000">3. What is the best way to learn how to write drivers for sound cards </FONT>
<FONT COLOR="#000000">(I've ordered the 'Linux Device drivers' book for an overview)?</FONT>
<FONT COLOR="#000000">4. Does the fact it is USB make it harder?</FONT>
<FONT COLOR="#000000">I have experience in programming in c/c++ and would like to have crack </FONT>
<FONT COLOR="#000000">at writing a driver (even if I fail miserably!), but I don't want to </FONT>
<FONT COLOR="#000000">spend ages leaning this process if it's an impossible task because I </FONT>
<FONT COLOR="#000000">can't get the required information from Creative.  I am noticing many </FONT>
<FONT COLOR="#000000">exciting tools such as JACK and Ardour gaining momentum and my hope is </FONT>
<FONT COLOR="#000000">that soon Linux can be as good for play as it has proven to be for work :)</FONT>

<FONT COLOR="#000000">Thanks</FONT>

<FONT COLOR="#000000">Martin</FONT>


<FONT COLOR="#000000">-------------------------------------------------------------------------</FONT>
<FONT COLOR="#000000">Take Surveys. Earn Cash. Influence the Future of IT</FONT>
<FONT COLOR="#000000">Join SourceForge.net's Techsay panel and you'll get the chance to share your</FONT>
<FONT COLOR="#000000">opinions on IT &amp; business topics through brief surveys-and earn cash</FONT>
<FONT COLOR="#000000"><A HREF="http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</A></FONT>
<FONT COLOR="#000000">_______________________________________________</FONT>
<FONT COLOR="#000000">Alsa-devel mailing list</FONT>
<FONT COLOR="#000000"><A HREF="mailto:Alsa-devel@lists.sourceforge.net">Alsa-devel@lists.sourceforge.net</A></FONT>
<FONT COLOR="#000000"><A HREF="https://lists.sourceforge.net/lists/listinfo/alsa-devel">https://lists.sourceforge.net/lists/listinfo/alsa-devel</A></FONT>
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

--=-6qNs095fmmYs/ZuMUq4u--



--===============1111689407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1111689407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1111689407==--
