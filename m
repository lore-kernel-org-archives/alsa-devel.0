From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix codec device id format used by some dai_links
Date: Mon, 24 Jan 2011 12:01:34 +0000
Message-ID: <20110124120134.GB29925@opensource.wolfsonmicro.com>
References: <1295735888-25527-1-git-send-email-lars@metafoo.de>
 <20110122233309.GA22799@opensource.wolfsonmicro.com>
 <4D3B7361.3030800@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D3B7361.3030800@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "for 2.6.37" <stable@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 23, 2011 at 01:16:33AM +0100, Lars-Peter Clausen wrote:

> I could resend the patch with those three cases which were definitely wrong in the
> current patch fixed to use the correct SPI or platform id. Or I could just send the
> fix for the neo1973 and neo1973_gta02 boards. Which one do you prefer?

Please submit just the stuff you know is a good fix.
