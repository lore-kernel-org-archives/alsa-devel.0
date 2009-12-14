From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC update for 2.6.33
Date: Mon, 14 Dec 2009 12:15:05 +0000
Message-ID: <20091214121505.GD22388@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5D6972457D
	for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2009 13:15:06 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 761c9d45d14e0afa3c0b8eb84b4075602e50533b:
  Olof Johansson (1):
        ASoC: Fix build of OMAP sound drivers

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33

Another small bugfix:

Julia Lawall (1):
      ASoC: Correct code taking the size of a pointer

 sound/soc/codecs/wm8900.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
