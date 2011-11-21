From: Dmitry Nezhevenko <dion@inhex.net>
Subject: Re: Commit d6cc9fabd58f33e829a3182aa856db0d57c726ef
 breaks built-in mic on ASUS F6A
Date: Mon, 21 Nov 2011 20:38:16 +0200
Message-ID: <20111121183816.GA23354@laptop.local>
References: <20111121192713.GA3677@laptop.local> <s5hr511iczy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dion.org.ua (dion.org.ua [193.104.35.143])
	by alsa0.perex.cz (Postfix) with ESMTP id 9675310390B
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 19:38:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hr511iczy.wl%tiwai@suse.de>
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

On Mon, Nov 21, 2011 at 06:47:29PM +0100, Takashi Iwai wrote:
> At Mon, 21 Nov 2011 21:27:13 +0200,
> Dmitry Nezhevenko wrote:
> > 
> > Hi,
> > 
> > I've found that internal doesn't work on kernel 3.1 while previous verison
> > (3.0) is ok.
> 
> This should have been already fixed in 3.1.1 kernel.  Give it a try.

Sorry. I've not mentioned it before. I'm on 3.1.1 now and still no luck.
arecord just get silence and VU-meter display nothing.

Regards.

-- 
WBR, Dmitry
