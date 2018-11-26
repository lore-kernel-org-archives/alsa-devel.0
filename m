From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 3/8] ASoC: dt-bindings: add regulator property to
 simple amplifier
Date: Mon, 26 Nov 2018 13:14:32 -0600
Message-ID: <20181126191432.GA30762@bogus>
References: <20181122102325.29495-1-wens@csie.org>
 <20181122102325.29495-4-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181122102325.29495-4-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Vasily Khoruzhick <anarsoul@gmail.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 22 Nov 2018 18:23:20 +0800, Chen-Yu Tsai wrote:
> From: Vasily Khoruzhick <anarsoul@gmail.com>
> 
> Amplifier may have associated regulator, so add a property for it.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/sound/simple-amplifier.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
