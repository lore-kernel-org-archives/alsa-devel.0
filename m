From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: ssm2602: Set initial bias level
	to standby
Date: Tue, 27 Sep 2011 11:22:17 +0100
Message-ID: <20110927102217.GE2910@opensource.wolfsonmicro.com>
References: <1317114528-16736-1-git-send-email-lars@metafoo.de>
	<1317114528-16736-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 60D4D10395E
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 12:22:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317114528-16736-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 27, 2011 at 11:08:47AM +0200, Lars-Peter Clausen wrote:
> Set the initial bias level to standby during CODEC probe instead of leaving the
> CODEC powered off.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Applied, thanks.
