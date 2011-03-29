From: Svante Signell <srs@kth.se>
Subject: Re: Problems with snd_hda_intel in Linux kernel 2.6.38
Date: Tue, 29 Mar 2011 12:58:16 +0200
Message-ID: <1301396296.32453.1.camel@s1499.it.kth.se>
References: <1301394280.3906.29.camel@s1499.it.kth.se>
	<s5haage43qz.wl%tiwai@suse.de>
Reply-To: srs@kth.se
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-2.sys.kth.se (smtp-2.sys.kth.se [130.237.32.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A2BD243C1
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Mar 2011 12:58:19 +0200 (CEST)
In-Reply-To: <s5haage43qz.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-03-29 at 12:31 +0200, Takashi Iwai wrote:
> At Tue, 29 Mar 2011 12:24:40 +0200,
> Svante Signell wrote:
> > 
> > > This problem was also reported as Debian bug #613979, as kernel ticket
> > > 
> > > https://bugzilla.kernel.org/show_bug.cgi?id=30552
> 
> Did you look at this?

Yes I did. So you recommend me to compile a new kernel? 

> Also, please try to decode the line from the code shown in the Oops.
> It's a bit too little information to analyze, unfortunately.

I know there is little information, but the computer hangs during boot
as shown in the bug report and the information there is copied manually
during the timeout period. Then everything is blanked out since the boot
continues. Any ideas?
