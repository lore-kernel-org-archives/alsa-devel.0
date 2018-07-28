From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v0 0/3] ASoC: max9867: driver update
Date: Sat, 28 Jul 2018 17:41:34 +0200
Message-ID: <20180728154134.GA9665@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id AA49F267766
 for <alsa-devel@alsa-project.org>; Sat, 28 Jul 2018 17:41:36 +0200 (CEST)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23993003AbeG1Plfy5Pf0 (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Sat, 28 Jul 2018 17:41:35 +0200
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi there,

after this patch serie, I'm finally able to use max9867 codec. This brings
in a question how was this driver tested and whenever these tests can be
repeated with this patchset applied.

Anyway, this serie is intentionally marked as v0 as I'm unclear about few
things described in comment section of respective patches. I'd be very happy
for answers as they are missing in documentation and are not obvious from
other drivers code.

Thank you in advance,
	ladis
