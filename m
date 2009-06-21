From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.31
Date: Sun, 21 Jun 2009 14:15:31 +0100
Message-ID: <20090621131530.GA6001@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B9F62437E
	for <alsa-devel@alsa-project.org>;
	Sun, 21 Jun 2009 15:15:39 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The following changes since commit ef39412622b6e8f09c383de9565b07e93553fc27:
  Takashi Iwai (1):
        ASoC: Kill BUS_ID_SIZE

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.31

Barry Song (1):
      ASoC: Blackfin: update the bf5xx_i2s_resume parameters

Cliff Cai (1):
      ASoC: Blackfin: keep better track of SPORT configuration state

 sound/soc/blackfin/bf5xx-i2s.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)
