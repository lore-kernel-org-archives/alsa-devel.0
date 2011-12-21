From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: missed hx4700-audio platform device for
	hx4700
Date: Wed, 21 Dec 2011 00:32:09 +0000
Message-ID: <20111221003209.GB13529@sirena.org.uk>
References: <1324114379.28427.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A44FE2433C
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2011 01:32:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1324114379.28427.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Dmitry Artamonow <mad_soft@inbox.ru>, linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@marvell.com>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 17, 2011 at 05:32:59PM +0800, Axel Lin wrote:
> The iPAQ hx4700 machine driver needs a hx4700-audio platform device which is
> not (yet) merged.

> The patchs was post on LKML: https://lkml.org/lkml/2011/5/18/222
> but [PATCH v3 3/3] pxa/hx4700: add platform device and I2C info for AK4641 codec is missed.

You probably want to resend the patch to the PXA maintainers with an
appropriate subject line.
