From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Packages 1.0.30 - release pending
Date: Wed, 4 Nov 2015 15:29:21 +0100
Message-ID: <563A1641.1070503@perex.cz>
References: <561AB391.6030504@perex.cz> <s5hvbaca40c.wl-tiwai@suse.de>
 <s5hlhaomjem.wl-tiwai@suse.de> <1445959655.7199.12.camel@loki>
 <F46914AEC2663F4A9BB62374E5EEF8F84B866C43@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id DC99D260522
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 15:29:25 +0100 (CET)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F84B866C43@shsmsx102.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dne 28.10.2015 v 16:06 Lin, Mengdong napsal(a):

> I expect the other kernel and user space patches will be submitted next week after the internal review.

Any progress for the user space? If I don't receive the updates for the
user space packages until Friday CEST morning, I'll release 1.1.0
without them. We can release 1.1.1 quickly when all things are finished
for the topology code. The distributions can adapt to new tools (like
alsatplg) in 1.1.0 and then just receive the updated code (1.1.1).

			Thanks,
				Jaroslav

BTW: Everyone probably found testing packages on FTP - /pub/testing or
through the snapshot page.

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
