From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel][PATCH 4/4] ASoC: wm8960: Fix capture sample rate
	from 11250 to 11025
Date: Tue, 6 Jan 2015 13:28:58 +0000
Message-ID: <20150106132858.GP14516@opensource.wolfsonmicro.com>
References: <1419997154-860-1-git-send-email-b50113@freescale.com> <1419997154-860-4-git-send-email-b50113@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1419997154-860-4-git-send-email-b50113@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <b50113@freescale.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, lars@metafoo.de, Li.Xiubo@freescale.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 31, 2014 at 11:39:14AM +0800, Zidan Wang wrote:
> wm8960 codec can't support sample rate 11250, it must be 11025.
> 
> Signed-off-by: Zidan Wang <b50113@freescale.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
