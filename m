From: Timur Tabi <timur@freescale.com>
Subject: Re: [GIT PULL] ASoC updates for 2.6.36
Date: Mon, 2 Aug 2010 11:24:57 -0500
Message-ID: <AANLkTi=6z_vTCEsJEiA0xQhn=-pO3wGAEW_+vdTKG4xm@mail.gmail.com>
References: <1280742830.3095.33.camel@odin> <s5hpqy1nx00.wl%tiwai@suse.de>
	<1280745056.3095.46.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B91B103820
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 18:25:28 +0200 (CEST)
Received: by qwi2 with SMTP id 2so1725182qwi.38
	for <alsa-devel@alsa-project.org>; Mon, 02 Aug 2010 09:25:27 -0700 (PDT)
In-Reply-To: <1280745056.3095.46.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 2, 2010 at 5:30 AM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> Ok, the multi-component branch does touch arch quite a bit as we are
> adding platform devices for all our components. So it's probably safer
> for merging (after your pull request) in the for 2.6.37 period to reduce
> any merge conflict with arch.

Um, I was really expecting my code to be part of 2.6.36.  Why are we
concerned with merge conflicts?  That's going to happen no matter
what.

-- 
Timur Tabi
Linux kernel developer at Freescale
