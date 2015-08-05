From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Subject: Re: [PATCH v2 0/4] Add SPDIF support for rockchip
Date: Wed, 05 Aug 2015 08:42:01 +0200
Message-ID: <1438756921.27576.4.camel@collabora.co.uk>
References: <1438687099-14282-1-git-send-email-sjoerd.simons@collabora.co.uk>
	 <20150804153649.GP20873@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150804153649.GP20873@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, Heiko Stuebner <heiko@sntech.de>, Pawel Moll <pawel.moll@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2015-08-04 at 16:36 +0100, Mark Brown wrote:
> On Tue, Aug 04, 2015 at 01:18:15PM +0200, Sjoerd Simons wrote:
> 
> > Sjoerd Simons (4):
> >   ASoC: dt-bindings: add rockchip tranceiver bindings
> >   ASoc: rockchip: Add rockchip SPDIF transceiver driver
> 
> I only appear to have patch 2 (with the misspelt subject), not the
> binding documentation.

Applogies, Send that patch specifically to you now.

Seems get_maintainers.pl didn't include you in the list (nor the other
asoc maintainers in the list), I guess it might be good to add
Documentation/devicetree/bindings/sounds/ to the ASoC file list in
MAINTAINTERS ?

-- 
Sjoerd Simons
Collabora Ltd.
