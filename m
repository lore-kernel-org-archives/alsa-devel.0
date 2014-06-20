From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/2] ASoC: samsung: Extend snow driver to support MAX98091
Date: Fri, 20 Jun 2014 08:51:58 -0700
Message-ID: <CAD=FV=XKxvVqsfj5ka3203XfAhtVvzVCWo-rFjO_nfothRnXrA@mail.gmail.com>
References: <1403251396-17487-1-git-send-email-tushar.b@samsung.com>
	<1403251396-17487-2-git-send-email-tushar.b@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1403251396-17487-2-git-send-email-tushar.b@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tushar Behera <tushar.b@samsung.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, alsa-devel@alsa-project.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, tiwai@suse.de, "broonie@kernel.org" <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Tushar Behera <trblinux@gmail.com>
List-Id: alsa-devel@alsa-project.org

Tushar,

On Fri, Jun 20, 2014 at 1:03 AM, Tushar Behera <tushar.b@samsung.com> wrote:
> Peach-pi board has MAX98091 CODEC. Extend snow machine driver to support
> this board.
>
> Signed-off-by: Tushar Behera <tushar.b@samsung.com>
> ---
>  Documentation/devicetree/bindings/sound/snow.txt |    1 +
>  sound/soc/samsung/snow.c                         |    1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Doug Anderson <dianders@chromium.org>
