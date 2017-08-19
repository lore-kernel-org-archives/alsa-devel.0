From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [linux-sunxi] [PATCH v5 4/8] ASoC: sun4i-i2s: Add mclk enable
 regmap field
Date: Sat, 19 Aug 2017 23:12:31 +0800
Message-ID: <CAGb2v65pagZHJdgTfezhH5-iYdWS+4FWF9OV8jTCp4YrFNomnQ@mail.gmail.com>
References: <20170819124839.4034-1-codekipper@gmail.com> <20170819124839.4034-5-codekipper@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170819124839.4034-5-codekipper@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Code Kipper <codekipper@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-sunxi <linux-sunxi@googlegroups.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 19, 2017 at 8:48 PM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> The location of the mclk output enable bit is different on newer
> SoCs. Use a regmap field to enable it.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
