From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH v2] ASoC: wm8962: correct addresses for
 HPF_C_0/1
Date: Fri, 13 Nov 2015 10:07:13 +0000
Message-ID: <20151113100713.GB18889@ck-lbox>
References: <1447178882-12113-1-git-send-email-sachinpandhare@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447178882-12113-1-git-send-email-sachinpandhare@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sachinpandhare@gmail.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, lars@metafoo.de, axel.lin@ingics.com, jiada_wang@mentor.com, zidan.wang@freescale.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 10, 2015 at 11:38:02PM +0530, sachinpandhare@gmail.com wrote:
> From: Sachin Pandhare <sachinpandhare@gmail.com>
> 
> >From datasheet:
> R17408 (4400h) HPF_C_1
> R17409 (4401h) HPF_C_0
> 17048 -> 17408 (0x4400)
> 17049 -> 17409 (0x4401)
> 
> Signed-off-by: Sachin Pandhare <sachinpandhare@gmail.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
