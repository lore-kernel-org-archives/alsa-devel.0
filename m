From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Cleanup duplicated const
Date: Wed, 23 Nov 2011 13:11:58 +0000
Message-ID: <20111123131158.GC12227@opensource.wolfsonmicro.com>
References: <1322044840-32709-1-git-send-email-lars@metafoo.de>
	<1322053881-5270-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BE427103B09
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 14:11:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1322053881-5270-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 23, 2011 at 02:11:21PM +0100, Lars-Peter Clausen wrote:
> Commit 85e7652("ASoC: Constify snd_soc_dai_ops structs") accidentally
> introduced a few duplicated consts. This patch cleans it up.

Applied, thanks.
