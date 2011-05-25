From: Daniel Mack <zonque@gmail.com>
Subject: Re: Patch series for Fast Track Ultra mixer quirks
Date: Wed, 25 May 2011 09:46:25 +0200
Message-ID: <BANLkTi=4cTqUFkpHWw1RLGBbySFkpHCD1A@mail.gmail.com>
References: <1306307343-3247-1-git-send-email-zonque@gmail.com>
	<s5hoc2r2pnw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170])
	by alsa0.perex.cz (Postfix) with ESMTP id E0C33103836
	for <alsa-devel@alsa-project.org>;
	Wed, 25 May 2011 09:46:26 +0200 (CEST)
Received: by pxi19 with SMTP id 19so4917059pxi.29
	for <alsa-devel@alsa-project.org>; Wed, 25 May 2011 00:46:25 -0700 (PDT)
In-Reply-To: <s5hoc2r2pnw.wl%tiwai@suse.de>
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
Cc: gdiffey@gmail.com, alsa-devel@alsa-project.org, clemens@ladisch.de, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

On Wed, May 25, 2011 at 9:41 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 25 May 2011 09:08:58 +0200,
> Daniel Mack wrote:
>>
>> Here's the set of patches to make Fast Track Ultra mixer quirks possible.
>> It's just a split version of the patch we've discussed on the ALSA ML
>> before.
>
> Thanks.
>
> I'd have exported a function creating FU mixer element instead of the
> control element link, but your patches are simple enough, so I applied
> as is.

I can have a look at this later and send a fixup.

Thanks,
Daniel
