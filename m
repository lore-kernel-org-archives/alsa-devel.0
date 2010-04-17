From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] pxa: add namespace on ssp
Date: Sat, 17 Apr 2010 10:54:29 +0900
Message-ID: <20100417015428.GA25725@opensource.wolfsonmicro.com>
References: <k2s771cded01003310546y48e1431r71820b73f69e53d5@mail.gmail.com>
	<20100409111609.GA13281@sirena.org.uk>
	<m2p771cded01004152054yc1e0d362z16b8f931339e6f36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C1003103803
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Apr 2010 03:54:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m2p771cded01004152054yc1e0d362z16b8f931339e6f36@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 15, 2010 at 11:54:08PM -0400, Haojian Zhuang wrote:

> Excuse me for late response. Now patches are refreshed and they're
> still based on Eric's ssp-cleanup branch. Since these patches are
> relied on some ssp's fix. Do you want to immigrate these patches into
> ASoC's tree? Would you pull eric's ssp-cleanup branch into ASoC tree?

Pulling the SSP cleanup branch into both ASoC and PXA (or just ASoC) has
been what I've been suggesting, but I'm not sure if Eric is comfortable
with that idea?

Please post patch serieses individually, not as one big set of
attachments - it's much easier to apply using standard tools like git am.
