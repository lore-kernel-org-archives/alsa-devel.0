From: Yannick Beynet <beynet@fresnes.info>
Subject: Re: alsa 0.9.4 and gcc 3.3
Date: Tue, 24 Jun 2003 20:55:10 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EF89E8E.3010000@fresnes.info>
References: <3EF70464.1070004@fresnes.info> <s5hllvrx0py.wl@alsa2.suse.de>
Reply-To: beynet@fresnes.info
Mime-Version: 1.0
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hllvrx0py.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, Alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=US-ASCII">
  <title></title>
</head>
<body>
Takashi Iwai a &eacute;crit&nbsp;:<br>
<blockquote type="cite" cite="mids5hllvrx0py.wl@alsa2.suse.de">
  <pre wrap="">At Mon, 23 Jun 2003 15:45:08 +0200,
Yannick Beynet wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi !
I have a problem with configure script
My kernel has been made with gcc 3.3, alsa 's configure find that gcc 
version is 3.3 but it prints that compilers mismatch ... My kernel 
version is 2.4.21
Any Idea ? (It works with alsa 0.9.2 but not with alsa 0.9.4)
    </pre>
  </blockquote>
  <pre wrap=""><!---->
this should have been fixed on cvs.
could you try it?

if it doesn't work, please report the exact messages that configure
script told you.


 


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers &amp; Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting <a class="moz-txt-link-freetext" href="http://www.inetu.net/partner/index.php">http://www.inetu.net/partner/index.php</a>
_______________________________________________
Alsa-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Alsa-devel@lists.sourceforge.net">Alsa-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/alsa-devel">https://lists.sourceforge.net/lists/listinfo/alsa-devel</a>

  </pre>
</blockquote>
well,&nbsp; now configure script works with cvs sources !<br>
Thanks Takashi !!<br>
</body>
</html>



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
