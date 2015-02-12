From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [Patch V5 05/12] ASoC: codec: Add MAX98357A codec driver
Date: Thu, 12 Feb 2015 02:45:54 -0800
Message-ID: <20150212104554.GB27200@kwestfie-linux.qualcomm.com>
References: <1423707015-14527-1-git-send-email-kwestfie@codeaurora.org>
 <1423707015-14527-6-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423707015-14527-6-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 11, 2015 at 06:10:08PM -0800, Kenneth Westfield wrote:
> From: Kenneth Westfield <kwestfie@codeaurora.org>
> 
> Add codec driver for the Maxim MAX98357A DAC.
> 
> Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
> Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
> ---
>  sound/soc/codecs/Kconfig     |   4 ++
>  sound/soc/codecs/Makefile    |   2 +
>  sound/soc/codecs/max98357a.c | 145 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 151 insertions(+)
>  create mode 100644 sound/soc/codecs/max98357a.c

Posted changes from V4 to V5 here:
  http://mailman.alsa-project.org/pipermail/alsa-devel/2015-February/087872.html

Please drop this patch.

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
