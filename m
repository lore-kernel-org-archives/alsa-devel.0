From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Remove unused extern declarations
 for sh4_hac_dai and sh7760_soc_platform
Date: Wed, 14 Dec 2011 15:56:25 +0800
Message-ID: <20111214075624.GB3072@opensource.wolfsonmicro.com>
References: <1323779030.5064.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 63C8C24566
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 08:56:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1323779030.5064.1.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Manuel Lauss <manuel.lauss@googlemail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 13, 2011 at 08:23:50PM +0800, Axel Lin wrote:
> Both sh4_hac_dai and sh7760_soc_platform are changed to static
> by multi-component patch and they are not used in sh7760-ac97.c now.

Applied, thanks.
