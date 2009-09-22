From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.32
Date: Tue, 22 Sep 2009 11:00:43 -0700
Message-ID: <20090922180041.GA4690@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CA829103807
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Sep 2009 20:00:53 +0200 (CEST)
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

The following changes since commit 0c31cf3e4af79ea18bbd365b07ef0de207673894:
  Chaithrika U S (1):
        ASoC: DaVinci: Fixes to McASP configuration

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Barry Song (1):
      ASoC: some minor changes for AD1836 and AD1938 codec drivers

Phil Vandry (1):
      ASoC: wm8753: fix mapping when MONOMIX is set to Stereo

 sound/soc/codecs/ad1836.c |    3 +--
 sound/soc/codecs/ad1938.c |    2 +-
 sound/soc/codecs/wm8753.c |    1 +
 3 files changed, 3 insertions(+), 3 deletions(-)
