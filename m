From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [PATCH 0/7] TCO fixes for RME MADI/Raydat/AIO/AES
	cards
Date: Mon, 11 Mar 2013 11:42:23 +0100
Message-ID: <20130311104223.GP5601@ltw.loris.tv>
References: <1362872247-29029-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <s5hd2v6l3hk.wl%tiwai@suse.de> <s5h7glel2ko.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [188.40.101.23])
 by alsa0.perex.cz (Postfix) with ESMTP id C0B89265315
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2013 11:42:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h7glel2ko.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 11, 2013 at 10:15:35AM +0100, Takashi Iwai wrote:

> > > I've spent another day at IOSONO to work with them on QA patches
> > > for the RME MADI series, especially the optional TCO module (LTC
> > > synchronisation with video cameras).
> > > 
> > > Here are our results, all tested for an entire week in their lab.
> > 
> > Thanks, applied all patches now.
> 
> ... then I found an obvious build error.  I fixed up the patch with
> the following.

Mea culpa, I've prepared the series on an outdated out-of-tree repo
while travelling and forgot to transfer the prototypes to the kernel
repo.


Thanks for fixing.


Cheers

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
