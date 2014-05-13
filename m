From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4 2/5] ASoC: Move standard kcontrol
 helpers to the component level
Date: Tue, 13 May 2014 11:19:36 +0800
Message-ID: <20140513031934.GA8609@dragon>
References: <536CF16F.8010807@metafoo.de>
 <CAOMZO5Cb4Q80ux1R9EOcsaCPFsmxz3K5Obt02or=s0RitmPMKw@mail.gmail.com>
 <536CFBE7.3070805@metafoo.de> <20140510050747.GI2870@dragon>
 <536DCF6F.9020507@metafoo.de> <536DD108.2090607@metafoo.de>
 <20140510083131.GL2870@dragon> <536DE548.9050008@metafoo.de>
 <20140510091209.GM2870@dragon>
 <20140512105257.GG25203@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0140.outbound.protection.outlook.com [207.46.163.140])
 by alsa0.perex.cz (Postfix) with ESMTP id B44DD2652CE
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 05:19:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140512105257.GG25203@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Fabio Estevam <festevam@gmail.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, May 12, 2014 at 11:52:57AM +0100, Charles Keepax wrote:
> Looking at this a bit more can you let me know when it is
> failing, I assume it is in relation to setting the "Speaker
> Switch" control?

Yes, it is.

Shawn
