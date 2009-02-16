From: Brendan Minish <bminish@minish.org>
Subject: Re: Possible bug with ICE1712 driver
Date: Mon, 16 Feb 2009 19:54:30 +0000
Message-ID: <1234814070.4138.3.camel@localhost.localdomain>
References: <1234797376.4179.14.camel@localhost.localdomain>
	<s5hiqnaz7db.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ns1.westnet.ie (ns1.westnet.ie [88.81.100.2])
	by alsa0.perex.cz (Postfix) with ESMTP id E9D9824335
	for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2009 20:54:31 +0100 (CET)
In-Reply-To: <s5hiqnaz7db.wl%tiwai@suse.de>
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

On Mon, 2009-02-16 at 17:14 +0100, Takashi Iwai wrote:
> At Mon, 16 Feb 2009 15:16:16 +0000,
> Brendan Minish wrote:
> > Hello 
> > the driver for my M-Audio Delta66, snd_ice1712 fails when my machine
> > resumes from suspend.
> The driver doesn't support PM (yet).
> So, it's no bug but a feature :)

Thank you for the speedy reply and the answer to my issue. Have you any
idea when we might have do do without this feature ;-) 


regards
Brendan Minish
