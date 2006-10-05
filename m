From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: new rollback commits
Date: Thu, 05 Oct 2006 14:52:06 +0200
Message-ID: <m2odsr53ih.fsf@vador.mandriva.com>
References: <ALOGGER1160034648.34@alsa-project.org>
	<m2lknv6pju.fsf@vador.mandriva.com> <s5hpsd7oybr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from office.mandriva.com (ezoffice.mandriva.com [84.14.106.134])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2299424E
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Oct 2006 14:52:11 +0200 (MEST)
In-Reply-To: <s5hpsd7oybr.wl%tiwai@suse.de> (Takashi Iwai's message of "Thu,
	05 Oct 2006 12:23:52 +0200")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> > I think that:
> > - the reason of the rollback should be visible and the mail (aka
> >   the rollback commit changelog)
> > - the rollback commit changelog) should be in the suject line
> >   rather than the changelog of the commit we reverse to, since
> >   it's more important
> 
> The rollback has no log for itself...

I think it would be better to actually log the rollback reason.
that's part of history after all.
not a big deal anyway...

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
