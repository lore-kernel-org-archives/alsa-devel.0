From: Daniel Jacobowitz <drow@false.org>
Subject: Re: [RFC] [Patch 1/2] Add virtual master control
Date: Tue, 6 May 2008 11:45:40 -0400
Message-ID: <20080506154540.GA24144@caradoc.them.org>
References: <s5hlk7p2wvm.wl%tiwai@suse.de>
	<20080130151909.GA11068@caradoc.them.org>
	<s5hprvj2v1w.wl%tiwai@suse.de>
	<20080321190855.GA24510@caradoc.them.org>
	<s5hiqzf15x8.wl%tiwai@suse.de>
	<20080322153046.GA4439@caradoc.them.org>
	<s5hzlsqzpnq.wl%tiwai@suse.de>
	<20080322191551.GA16147@caradoc.them.org>
	<20080502180154.GA13965@caradoc.them.org>
	<s5hskwvh378.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nan.false.org (NaN.false.org [208.75.86.248])
	by alsa0.perex.cz (Postfix) with ESMTP id 2512824400
	for <alsa-devel@alsa-project.org>;
	Tue,  6 May 2008 17:45:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hskwvh378.wl%tiwai@suse.de>
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

On Tue, May 06, 2008 at 05:17:31PM +0200, Takashi Iwai wrote:
> Not quite, unfortunately.  But, in the end, I think it's relatively
> harmless to take your patch as is, since it's pretty local to VT161x
> codecs.
> 
> I'll put it on my local tree and make testing, then merge to the
> public tree soon later.

Great, thanks a lot!  I agree it could be improved - but I'll leave
that for another future user :-)

-- 
Daniel Jacobowitz
CodeSourcery
