From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.29
Date: Mon, 9 Feb 2009 11:18:34 +0000
Message-ID: <20090209111832.GA14843@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E00A103800
	for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2009 12:18:41 +0100 (CET)
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

The following changes since commit 64ca0404eed57f6c92290d55e949a7f46cbe4bf4:
  Liam Girdwood (1):
        ALSA: ASoC: email - update email addresses.

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.29

Eero Nurkkala (1):
      ASoC: TLV320AIC3X: Fix kcontrol's private value use in put callback

Jarkko Nikula (1):
      ASoC: WM8990: Fix kcontrol's private value use in put callback

 sound/soc/codecs/tlv320aic3x.c |   11 +++++++----
 sound/soc/codecs/wm8990.c      |    4 +++-
 2 files changed, 10 insertions(+), 5 deletions(-)
