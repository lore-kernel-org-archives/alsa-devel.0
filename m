From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: Bug#245668: kernel-source-2.6.5:
	intel8x0:	IEC958 output not working anymore
Date: Fri, 03 Sep 2004 19:12:13 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1094253132.6575.77.camel@krustophenia.net>
References: <Pine.HPX.4.33n.0409031438540.16124-100000@studcom.urz.uni-halle.de>
	 <1094220009.4139.3.camel@atari.stigge.org>  <s5hzn47whwn.wl@alsa2.suse.de>
	 <1094229580.4140.7.camel@atari.stigge.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id F3FAB11E
	for <alsa-devel@alsa-project.org>; Sat,  4 Sep 2004 01:12:09 +0200 (MEST)
In-Reply-To: <1094229580.4140.7.camel@atari.stigge.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Roland Stigge <stigge@antcom.de>
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, maks attems <debian@sternwelten.at>, 245668@bugs.debian.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-09-03 at 12:39, Roland Stigge wrote:
> When I played around I noticed that gnome-alsamixer segfaults when I
> _uncheck_ "IEC958" during the playback:

Looks like a bug in gnome-alsamixer.  This is not developed by the ALSA
project, please file a bug report with your distro.

Does it work with regular alsamixer?

Lee



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
