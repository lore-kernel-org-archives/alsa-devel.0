From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: alsa-info.sh
Date: Thu, 31 Jan 2008 17:12:31 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0801311707020.6131@tm8103.perex-int.cz>
References: <1201754941.7685.4.camel@localhost>
	<1201763039.23369.56.camel@razman.gruemaster.com>
	<Pine.LNX.4.61.0801311134590.6131@tm8103.perex-int.cz>
	<1201789531.23369.74.camel@razman.gruemaster.com>
	<s5hodb2131w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F61A2443A
	for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2008 17:12:32 +0100 (CET)
In-Reply-To: <s5hodb2131w.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 31 Jan 2008, Takashi Iwai wrote:

> At Thu, 31 Jan 2008 06:25:31 -0800,
> Tobin Davis wrote:
> > 
> > I'll get in tough with the script writer and find out.  His name is
> > wishie on #alsa at irc.freenode.net.
> 
> Maybe we can add just a link?

I though about this, but I'd like to have such script at official server 
somewhere. The /alsa HG repo is exactly created for this purpose, and we 
can eventually track changes in this script also from the security 
perspective.

> One thing missing in this script is the alsactl file.  It's often
> pretty helpful and more obvious than codec proc files for some trivial
> bugs like mixer misconfiguration.

Another reason to have this script under control ;-)

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
