From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2 4/4] ASOC: sunxi: Add support for the spdif block
Date: Thu, 1 Oct 2015 02:26:34 +0800
Message-ID: <201510010229.uleM0Oxk%fengguang.wu@intel.com>
References: <1443635458-8873-5-git-send-email-codekipper@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1443635458-8873-5-git-send-email-codekipper@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, maxime.ripard@free-electrons.com, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org, broonie@kernel.org, linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, be17068@iperbole.bo.it, Marcus Cooper <codekipper@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Marcus,

[auto build test results on next-20150930 -- if it's inappropriate base, please ignore]


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/sunxi/sun4i-spdif.c:599:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
