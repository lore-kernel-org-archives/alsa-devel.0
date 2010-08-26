From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: rx51: Remove redefinition of
	rx51_aic3x_data
Date: Thu, 26 Aug 2010 13:49:30 -0700
Message-ID: <20100826204929.GC12567@atomide.com>
References: <1282548905-10287-1-git-send-email-jhnikula@gmail.com>
	<20100823095851.GC6061@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mho-01-ewr.mailhop.org (mho-01-ewr.mailhop.org [204.13.248.71])
	by alsa0.perex.cz (Postfix) with ESMTP id D74AC243A6
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Aug 2010 22:49:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100823095851.GC6061@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

* Mark Brown <broonie@opensource.wolfsonmicro.com> [100823 02:51]:
> On Mon, Aug 23, 2010 at 10:35:05AM +0300, Jarkko Nikula wrote:
> > Redefinition of rx51_aic3x_data got introduced when merging upstread changes
> > for 2.6.36 and ASoC Multi-Component Support.
> > 
> > This must go together with multi-component commit f0fba2a.
> > 
> > Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Tony Lindgren <tony@atomide.com>
