From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 1/3] mfd: Add WM1811 support
Date: Tue, 4 Oct 2011 12:19:02 +0200
Message-ID: <20111004101902.GV4118@sortiz-mobl>
References: <1317149407-27635-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1317149407-27635-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Tue, Sep 27, 2011 at 07:50:05PM +0100, Mark Brown wrote:
> The WM1811 is mostly register compatible with the WM8994 and WM8958,
> providing a high performance audio hub CODEC in a small form factor
> suitable for ultra compact system designs.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> 
> Due to the ASoC cross dependencies it seems like it'll be easier to
> merge this via ASoC - Samuel, does this make sense to you?
It does.
Liam, please add my:
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

to this one.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
