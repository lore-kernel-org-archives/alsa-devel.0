From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8904: fix DSP mode B configuration
Date: Wed, 18 Dec 2013 09:23:37 +0000
Message-ID: <20131218092337.GD11138@opensource.wolfsonmicro.com>
References: <1387337183-16814-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387337183-16814-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: broonie@kernel.org, patches@opensource.wolfsonmicro.com, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 18, 2013 at 11:26:23AM +0800, Bo Shen wrote:
> When wm8904 work in DSP mode B, we still need to configure it to
> work in DSP mode. Or else, it will work in Right Justified mode.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
