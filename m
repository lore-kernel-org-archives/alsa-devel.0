From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH 4/6] sound/usb/caiaq/device.c: fix use of
 MODULE_SUPPORTED_DEVICES()
Date: Tue, 29 Jan 2013 12:59:37 +0100
Message-ID: <20130129125937.f303cade107e996832446fc7@studenti.unina.it>
References: <1359412952-1680-1-git-send-email-ospite@studenti.unina.it>
 <1359412952-1680-5-git-send-email-ospite@studenti.unina.it>
 <89689420-8f6b-4119-b728-fb40f78be7d7@email.android.com>
 <s5h1ud4tpdi.wl%tiwai@suse.de>
 <20130129110833.6a085d126806be524fa223cc@studenti.unina.it>
 <s5h7gmwz2j9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp205.alice.it (smtp205.alice.it [82.57.200.101])
 by alsa0.perex.cz (Postfix) with ESMTP id AD38D261600
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2013 12:59:39 +0100 (CET)
In-Reply-To: <s5h7gmwz2j9.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, Antonio Ospite <ao2@amarulasolutions.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 29 Jan 2013 11:50:18 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Tue, 29 Jan 2013 11:08:33 +0100,
> Antonio Ospite wrote:
> > 
> > On Tue, 29 Jan 2013 08:33:29 +0100
> > Takashi Iwai <tiwai@suse.de> wrote:
> > 
[...] 
> > > The patches didn't reach me, possibly because of a problem of my
> > > server I've hit in this morning.
> > > 
> > > Antonio, could you repost the patch to me (and add Daniels' ack)?
> > > 
> > 
> > I will, I guess you missed the other patches in the same series as well?
> > Should I re-send all of them to you only?
> 
> Yes.  You don't have to resend to ML in this case.

Done.

> (BTW, did you add me to Cc in the original posts?)

Yes, I did.

Regards,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
