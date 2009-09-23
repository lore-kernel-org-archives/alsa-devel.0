From: Liviu Andronic <landronimirc@gmail.com>
Subject: Re: sound issues on an HP Pavilion DV3-1075 (solved)
Date: Wed, 23 Sep 2009 17:24:02 +0100
Message-ID: <68b1e2610909230924o1aa1340by1f47d9cb2cf7f1d8@mail.gmail.com>
References: <68b1e2610909220419j2cd1d86eu97a8f3202fa907be@mail.gmail.com>
	<68b1e2610909220421o77cc27fbg9597aa638c16c919@mail.gmail.com>
	<68b1e2610909230055r603e46em3e18aca9ad566078@mail.gmail.com>
	<604760770909230311o2aeb8ecfu4aa8707bce334610@mail.gmail.com>
	<68b1e2610909230606r6fc4b51ev8d9173fa4fa190b5@mail.gmail.com>
	<s5h7hvp21t3.wl%tiwai@suse.de>
	<68b1e2610909230731r52be7153tf19b91b861c539ff@mail.gmail.com>
	<s5hzl8lzpxt.wl%tiwai@suse.de>
	<68b1e2610909230827x2d6ccb22jd75faede988047d4@mail.gmail.com>
	<s5hr5txzn3x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f225.google.com (mail-ew0-f225.google.com
	[209.85.219.225])
	by alsa0.perex.cz (Postfix) with ESMTP id EBE2A1038AF
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Sep 2009 18:24:03 +0200 (CEST)
Received: by ewy25 with SMTP id 25so866032ewy.45
	for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2009 09:24:03 -0700 (PDT)
In-Reply-To: <s5hr5txzn3x.wl%tiwai@suse.de>
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
Cc: Daniel Chen <seven.steps@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 9/23/09, Takashi Iwai <tiwai@suse.de> wrote:
> Did you try it with the very latest version?
>
No. I have just got a working Debian install (after major upgrade,
sound and graphics broke), and I'm currently not ready to break the
system again.


>  enable_msi=1 should be OK, but position_fix=1 doesn't look necessary.
>  I'm asking this because I don't want to add unneeded option.
>
I will experiment as soon as the next version of alsa hits Debian
unstable, and I will report here.
Thank you
Liviu
