From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 0/9] ASoC Blackfin supporting (v2)
Date: Fri,  5 Sep 2008 18:21:33 +0800
Message-ID: <1220610102-7716-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 4839D245CF
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 12:21:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@sirena.org.uk
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


Hi Mark,

With Cliff's effort, we update this patch series quickly according to
your review.

v1-v2:
 - move ASoC Blackfin Kconfig and Makefile patch to be the last one
   in the series
 - fix coding style issues
 - The SND_SOC_DAFIMT_LEFT_J: ought to be default
 - fix other minor issues

v0-v1:
 - fix coding style issues
 - use latest ASoC API
 - split the whole patch into this 9 patches in a patchset

Thanks a lot
-Bryan
