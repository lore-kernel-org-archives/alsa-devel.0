From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/7] ASoC: fsl: mpc5200 combine psc_dma
	platform data
Date: Tue, 18 Sep 2012 23:03:54 -0400
Message-ID: <20120919030353.GP8832@opensource.wolfsonmicro.com>
References: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
 <1347572596-37540-3-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5632626514A
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 05:03:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1347572596-37540-3-git-send-email-emillbrandt@dekaresearch.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 13, 2012 at 05:43:11PM -0400, Eric Millbrandt wrote:
> The mpc5200_psc_ac97 and mpc5200_psc_i2s modules rely on shared platform data
> with mpc5200_dma.

Applied, thanks.
