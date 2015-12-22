From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 5/6] ASoC: da7219: Add support for 1.6V micbias level
Date: Tue, 22 Dec 2015 16:37:25 -0600
Message-ID: <20151222223725.GA21864@rob-hp-laptop>
References: <cover.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
 <7413a3e6c9996d2ae4c17ea60b220ad1d4012a9f.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7413a3e6c9996d2ae4c17ea60b220ad1d4012a9f.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 22, 2015 at 06:27:55PM +0000, Adam Thomson wrote:
> HW can provide 1.6V micbias level as well the existing levels
> already provided in the driver. This patch adds support for 1.6V
> to the DT binding.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
>  Documentation/devicetree/bindings/sound/da7219.txt | 2 +-

Acked-by: Rob Herring <robh@kernel.org>
