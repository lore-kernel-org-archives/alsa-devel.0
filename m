From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] alsa/soc: Fix typo in MPC5200 PSC AC97
	driver	Kconfig
Date: Mon, 29 Jun 2009 10:35:51 +0100
Message-ID: <20090629093550.GC11855@sirena.org.uk>
References: <20090628074109.26905.9927.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E1F410382A
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Jun 2009 11:35:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090628074109.26905.9927.stgit@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, timur@freescale.com
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 28, 2009 at 01:41:52AM -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> ALSA SoC drivers should be specify SND_SOC_AC97_BUS instead, not AC97_BUS.

Applied both.
