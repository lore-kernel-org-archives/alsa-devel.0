From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add "Line In" input jack constants
Date: Wed, 5 Oct 2011 20:36:28 -0700
Message-ID: <20111006033627.GA20217@core.coreip.homeip.net>
References: <4E8C6332.2080902@canonical.com>
 <s5haa9f302i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D6EEA103A18
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Oct 2011 05:36:38 +0200 (CEST)
Received: by iabn5 with SMTP id n5so2760865iab.38
	for <alsa-devel@alsa-project.org>; Wed, 05 Oct 2011 20:36:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5haa9f302i.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 05, 2011 at 05:55:17PM +0200, Takashi Iwai wrote:
> At Wed, 05 Oct 2011 16:01:22 +0200,
> David Henningsson wrote:
> > 
> > Hi,
> > 
> > Do you think this is reasonable to apply to 3.2? If so I'll continue 
> > with writing some patches that use this new constant, of course.
> 
> Oh, we should add Dmitry to Cc, since the patch touchs linux/input.h.
> Dmitry, is it OK to add SW_LINEIN_INSERT as below?
> 

Yeah, that should be OK.

Thanks.

-- 
Dmitry
