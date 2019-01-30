From: Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Subject: [PATCH 0/3] sound: 3 cosmetic patches
Date: Wed, 30 Jan 2019 17:22:38 +0100
Message-ID: <1548865361-12816-1-git-send-email-guennadi.liakhovetski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C5F22674A3
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 17:22:43 +0100 (CET)
Received: from axis700.grange ([87.78.226.14]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LzKmP-1hARrW1dcf-014T3J for
 <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 17:22:43 +0100
Received: from 200r.grange (200r.grange [192.168.1.16])
 by axis700.grange (Postfix) with ESMTP id 3085661CB8
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 17:22:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

3 trivial cosmetic patches.

Guennadi Liakhovetski (3):
  sound: (cosmetic) remove a superfluous function declaration
  asoc: (cosmetic) simplify a condition
  asoc: (cosmetic) simplify a function

 sound/core/pcm_native.c  | 2 --
 sound/soc/soc-core.c     | 4 ++--
 sound/soc/soc-topology.c | 6 +-----
 3 files changed, 3 insertions(+), 9 deletions(-)

-- 
2.17.1
