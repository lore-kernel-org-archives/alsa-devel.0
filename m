From: Daniel Drake <dsd@gentoo.org>
Subject: Re: Regression in 2.6.19 and 2.6.20 for snd_hda_intel
Date: Sat, 30 Dec 2006 22:46:11 -0500
Message-ID: <45973283.7060801@gentoo.org>
References: <45971053.7040609@lwfinger.net> <45971F39.4060301@gentoo.org>
	<45972EFD.3010103@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtp151.iad.emailsrvr.com (smtp151.iad.emailsrvr.com
	[207.97.245.151])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B4D622C9
	for <alsa-devel@alsa-project.org>; Sun, 31 Dec 2006 04:44:46 +0100 (MET)
In-Reply-To: <45972EFD.3010103@lwfinger.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Larry Finger <larry.finger@lwfinger.net>
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Stephen Hemminger <shemminger@osdl.org>
List-Id: alsa-devel@alsa-project.org

Larry Finger wrote:
> You are correct. Only the "hda_codec-Add independent headphone volume control" needs to be reverted.

The best course of action is probably to file a report here:
https://bugtrack.alsa-project.org/alsa-bug

Daniel

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
