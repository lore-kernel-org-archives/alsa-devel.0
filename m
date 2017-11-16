From: Joe Perches <joe@perches.com>
Subject: [PATCH 0/2] ASoC: fsl_asrc: neatening
Date: Thu, 16 Nov 2017 08:25:45 -0800
Message-ID: <cover.1510849466.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.hostedemail.com (smtprelay0130.hostedemail.com
 [216.40.44.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 4859C266EE4
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 17:25:53 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Joe Perches (2):
  ASoC: fsl_asrc: Fix line continuation format
  ASoC: fsl_asrc: constify some arrays

 sound/soc/fsl/fsl_asrc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.15.0
