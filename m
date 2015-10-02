From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] ASoC: nau8825: Add driver for headset chip
 Nuvoton 8825
Date: Sat, 3 Oct 2015 03:37:59 +0800
Message-ID: <201510030325.7iMIFZm3%fengguang.wu@intel.com>
References: <1443804554-36592-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 99DA02614A9
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2015 21:38:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1443804554-36592-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: mfelton1@nuvoton.com, Anatol Pomozov <anatol.pomozov@gmail.com>, alsa-devel@alsa-project.org, benzh@google.com, broonie@kernel.org, kbuild-all@01.org, ccchang12@nuvoton.com
List-Id: alsa-devel@alsa-project.org

Hi Anatol,

[auto build test results on next-20151002 -- if it's inappropriate base, please ignore]


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/codecs/nau8825.c:1096:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
