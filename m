From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Fix SND_SOC_ALL_CODECS typos for
 alc5623 and jz4740
Date: Mon, 1 Nov 2010 09:46:56 -0400
Message-ID: <20101101134656.GA24374@opensource.wolfsonmicro.com>
References: <1288360065-9793-1-git-send-email-jhnikula@gmail.com>
	<20101101132253.GA23423@opensource.wolfsonmicro.com>
	<20101101153112.13a01f28.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 58A12103821
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 14:46:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101101153112.13a01f28.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 01, 2010 at 03:31:12PM +0200, Jarkko Nikula wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > This patch doesn't apply as-is since this CODEC isn't in mainline.  I've
> > dropped it from the patch and applied together with the second patch.

> Ah, I forgot to point these were for 2.6.38 and thus alc5623 were
> here. I thought SND_SOC_ALL_CODECS is useful only to ASoC developers
> and didn't consider .37 at all :-)

Ah, please resubmit the separate patch fo 2.6.38.
