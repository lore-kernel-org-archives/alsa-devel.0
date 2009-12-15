From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Another 2.6.33 ASoC fix
Date: Tue, 15 Dec 2009 15:11:44 +0000
Message-ID: <20091215151144.GA30694@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B4AC4103882
	for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2009 16:11:45 +0100 (CET)
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

The following changes since commit bc2580061e42c323d7777029f01318f395edac0d:
  Julia Lawall (1):
        ASoC: Correct code taking the size of a pointer

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33

Kuninori Morimoto (1):
      ASoC: ak4642: Add default return value in ak4642_modinit

 sound/soc/codecs/ak4642.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
