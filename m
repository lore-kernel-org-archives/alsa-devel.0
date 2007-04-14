From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [v4l-dvb-maintainer] [2/3] 2.6.21-rc6: known
	regressions
Date: Sat, 14 Apr 2007 10:17:10 -0300
Message-ID: <1176556630.11211.20.camel@areia>
References: <Pine.LNX.4.64.0704051944230.6730@woody.linux-foundation.org>
	<20070414003801.GT5907@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20070414003801.GT5907@stusta.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Adrian Bunk <bunk@stusta.de>
Cc: Oliver Neukum <oneukum@suse.de>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Hans-Georg Rist <hg.rist@web.de>, greg@kroah.com, Tino Keitel <tino.keitel@gmx.de>, alsa-devel@alsa-project.org, Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo@kvack.org>, Markus Rechberger <markus.rechberger@amd.com>, CIJOML <cijoml@volny.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, v4l-dvb-maintainer@linuxtv.org, perex@suse.cz, linux-usb-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Adrian,

Em S=E1b, 2007-04-14 =E0s 02:38 +0200, Adrian Bunk escreveu:

> Subject    : USB: Oops when changing DVB-T adapter
> References : http://lkml.org/lkml/2007/3/9/212
> Submitter  : CIJOML <cijoml@volny.cz>
> Handled-By : Markus Rechberger <markus.rechberger@amd.com>
> Patch      : http://lkml.org/lkml/2007/4/5/154
> Status     : patches available

I'm committing the fixes for DVB USB hotplug today at V4L/DVB devel
tree. I was waiting some more tests during this fix, since it is a
change at dvb core.

I'm out of my town during this week, with a very limited resources here.
I should return back tomorrow. Then I will generate the -git fixes and
send Linus.

Cheers,
Mauro


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
