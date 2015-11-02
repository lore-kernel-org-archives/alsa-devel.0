From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 2/2] ASoC: wm9713: use snd_soc_*() calls to update
 ac97 registers
Date: Mon, 2 Nov 2015 09:06:51 +0000
Message-ID: <20151102090651.GN10520@ck-lbox>
References: <1446405820-24923-1-git-send-email-robert.jarzmik@free.fr>
 <1446405820-24923-2-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446405820-24923-2-git-send-email-robert.jarzmik@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 01, 2015 at 08:23:40PM +0100, Robert Jarzmik wrote:
> Convert wm9713 to use the more modern registers manipulation functions,
> such as snd_soc_read(), snd_soc_write() and snd_soc_update_bits().
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
