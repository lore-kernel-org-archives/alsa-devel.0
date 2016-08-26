From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v9 1/2] ASoC: sun4i-codec: Distinguish sun4i from sun7i
Date: Fri, 26 Aug 2016 15:04:38 +0800
Message-ID: <CAGb2v678PkvxM+8bvbmywFt1JZqqC+J8d1ZAvg_rKRs9UWgBfQ@mail.gmail.com>
References: <20160826065312.26803-1-dannym@scratchpost.org> <20160826065312.26803-2-dannym@scratchpost.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160826065312.26803-2-dannym@scratchpost.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Danny Milosavljevic <dannym@scratchpost.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 26, 2016 at 2:53 PM, Danny Milosavljevic
<dannym@scratchpost.org> wrote:
>
> This distinguishes sun4i from sun7i. It is necessary because they use
> different registers for the audio mixer.
> ---
>  sound/soc/sunxi/sun4i-codec.c | 44 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 10 deletions(-)
>

Please send your patches inline.

ChenYu
