From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] omap: rx51: Remove redefinition of
	rx51_aic3x_data
Date: Mon, 23 Aug 2010 10:58:51 +0100
Message-ID: <20100823095851.GC6061@rakim.wolfsonmicro.main>
References: <1282548905-10287-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1FB2224464
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Aug 2010 11:58:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1282548905-10287-1-git-send-email-jhnikula@gmail.com>
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
Cc: Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 23, 2010 at 10:35:05AM +0300, Jarkko Nikula wrote:
> Redefinition of rx51_aic3x_data got introduced when merging upstread changes
> for 2.6.36 and ASoC Multi-Component Support.
> 
> This must go together with multi-component commit f0fba2a.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
