From: Mark Brown <broonie@sirena.org.uk>
Subject: ASoC update for 2.6.29
Date: Tue, 20 Jan 2009 20:58:03 +0000
Message-ID: <20090120205802.GA7686@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 48B181037E3
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 21:58:14 +0100 (CET)
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

The following changes since commit 591046cfc5f1b452db0a4557850ad7f394e38231:
  Ben Nizette (1):
        ASoC: atmel_pcm: Remove non-existant header

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.29

Timur Tabi (1):
      ASoC: fix registration of the SoC card in the Freescale MPC8610 drivers

 sound/soc/fsl/mpc8610_hpcd.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)
