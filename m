From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: fsl-asoc-card: add cs4271 and cs4272 support
Date: Mon, 1 Feb 2016 09:23:20 -0600
Message-ID: <20160201152320.GA15750@rob-hp-laptop>
References: <1454065261-9522-1-git-send-email-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454065261-9522-1-git-send-email-eu@felipetonello.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Felipe F. Tonello" <eu@felipetonello.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Nicolin Chen <nicoleotsuka@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 29, 2016 at 11:01:00AM +0000, Felipe F. Tonello wrote:
> add cs4271 and cs42727 support for fsl-asoc-card
> 
> Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-asoc-card.txt | 9 +++++++++
>  sound/soc/fsl/Kconfig                                     | 4 ++--
>  sound/soc/fsl/fsl-asoc-card.c                             | 7 +++++++
>  3 files changed, 18 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
