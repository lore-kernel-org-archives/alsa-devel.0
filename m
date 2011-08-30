From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 1/1] ASoC: omap-mcpdm: Replace legacy
	driver
Date: Tue, 30 Aug 2011 14:24:00 +0100
Message-ID: <20110830132400.GG2061@opensource.wolfsonmicro.com>
References: <1314624327-28384-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F01B62414F
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Aug 2011 15:24:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1314624327-28384-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 29, 2011 at 04:25:27PM +0300, Peter Ujfalusi wrote:
> From: Misael Lopez Cruz <misael.lopez@ti.com>
> 
> Reasons for the replacement:
> The current driver for McPDM was developed to support the legacy mode only.
> In preparation for the ABE support the current driver stack need the be
> replaced.
> The new driver is much simpler, easier to extend, and it also fixes some of the
> issues with the old stack.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
