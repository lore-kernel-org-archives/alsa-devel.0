From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [GIT PULL]
Date: Tue, 10 Apr 2012 13:05:47 -0600
Message-ID: <4F84848B.50604@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 46BAA247AA
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Apr 2012 21:05:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark,

Could you please pull the following branches into ASoC's for-next:

git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git topic/mmio

git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git
topic/stride

Those two are a dependency for the Tegra20 ASoC regmap conversion that I
can post now.

git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git topic/name

That is an additional dependency for the new Tegra30 ASoC drivers.

Thanks.
