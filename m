From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel][PATCH 4/4] ASoC: wm8958: correct BCLK DIV 348 to
	384
Date: Tue, 12 May 2015 11:43:42 +0100
Message-ID: <20150512104342.GG3480@opensource.wolfsonmicro.com>
References: <c36ecb00aeb3115e208518c5e256f35f7b1308db.1431413323.git.zidan.wang@freescale.com> <db8ef4eba13e06c27b1da3762fdbd79be3afac2a.1431413323.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <db8ef4eba13e06c27b1da3762fdbd79be3afac2a.1431413323.git.zidan.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: tiwai@suse.de, broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 12, 2015 at 02:58:50PM +0800, Zidan Wang wrote:
> According to the RM of wm8958, BCLK DIV 348 doesn't exist, correct it
> to 384.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
