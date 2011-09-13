From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [alsa-devel] [PATCH 0/3] ASoC: tpa6130a2: model handling cleanup
Date: Tue, 13 Sep 2011 15:11:41 +0300
Message-ID: <3889212.SkWsu33aHd@barack>
References: <1314704394-31298-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1314704394-31298-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Girdwood, Liam" <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Hello Mark, Tony,

On Tuesday 30 August 2011 13:39:51 Ujfalusi, Peter wrote:
> Hello,
>=20
> Small cleanup for the tpa6130a2 driver for model handling:
> Remove the model_id from platform_data, and use the device name/devic=
e_data
> to distinguish between the supported models of TPA.

Would you have time to take a look at this series (it got the Tested-by=
 from=20
Jarkko)?

Thank you,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
