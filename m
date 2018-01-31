From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 0/2] ASoC: stm32: spdifrx: change dai name
Date: Wed, 31 Jan 2018 17:47:01 +0100
Message-ID: <1517417223-21899-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E3EB2267656
 for <alsa-devel@alsa-project.org>; Wed, 31 Jan 2018 17:47:35 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com
Cc: arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

This patchset changes spdifrx dai name and fixes a typo issue.

Olivier Moysan (2):
  ASoC: stm32: spdifrx: fix typo in function name.
  ASoC: stm32: spdifrx: Use default dai name

 sound/soc/stm/stm32_spdifrx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
1.9.1
