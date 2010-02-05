From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC update for 2.6.33
Date: Fri, 5 Feb 2010 14:13:06 +0000
Message-ID: <20100205141305.GA2039@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A85F91038D0
	for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2010 15:13:07 +0100 (CET)
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

The following changes since commit 5bbd4953a4fb5d8d597b4a53b8da97eee320b634:
  Anuj Aggarwal (1):
        ASoC: AM3517: ASoC driver not getting compiled

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33

Grazvydas Ignotas (1):
      ASoC: pandora: Add APLL supply to fix audio output

 sound/soc/omap/omap3pandora.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
