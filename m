From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.0
Date: Thu, 14 Jul 2011 00:22:30 +0900
Message-ID: <20110713152228.GA8889@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1913524340
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 17:22:42 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 18361bbe3180eca62796188d62aefac1519f4c83:

  Merge branch 'for-3.0' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6 into fix/asoc (2011-07-09 09:44:09 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-3.0

Kuninori Morimoto (3):
      ASoC: sh: fsi-ak4642: fixup snd_soc_card name
      ASoC: sh: fsi-da7210: fixup snd_soc_card name
      ASoC: sh: fsi-hdmi: fixup snd_soc_card name

 sound/soc/sh/fsi-ak4642.c |   16 ++++++++--------
 sound/soc/sh/fsi-da7210.c |    2 +-
 sound/soc/sh/fsi-hdmi.c   |    4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)
