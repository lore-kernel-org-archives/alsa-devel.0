From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v9 0/2] sun4i-codec: Add Line-In, FM-In, Mic 2, Capture
 Source, Differential Line-In
Date: Tue, 30 Aug 2016 09:58:46 +0800
Message-ID: <CAGb2v641btw_4Y+s2Ufbk98N=ekwh6yfMQKLHModLM-4QPRsrg@mail.gmail.com>
References: <20160826072230.30429-1-dannym@scratchpost.org>
 <20160827120251.GQ3165@lukather> <20160829200347.7e6aa714@scratchpost.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160829200347.7e6aa714@scratchpost.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Danny Milosavljevic <dannym@scratchpost.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 30, 2016 at 2:03 AM, Danny Milosavljevic
<dannym@scratchpost.org> wrote:
> Hi Maxime,
>
> On Sat, 27 Aug 2016 14:02:51 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
>
>> Please send your patches using send-email.
>
> If you are referring to "git send-email", I did send the patch series using that (with almost the same setup I use for many other projects). It probably barfed because my description enumeration contained a dash like "- Line In". Sigh.

The problem is your patches are being treated as attachments.
Try using '--no-attach' with git format-patch, regenerate the patches
and check that they are not mulit-part before sending them again.

ChenYu

>
> Anyway, I'll send the E-Mail again.
>
> Thanks,
>    Danny
