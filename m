From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/intel 33/35]
 sound/soc/soc-core.c:1961:2-3: Unneeded semicolon
Date: Fri, 30 Jun 2017 00:27:13 +0800
Message-ID: <201706300009.TtWtyn5F%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 943E22673D3
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 18:27:41 +0200 (CEST)
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
To: Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/intel
head:   8cffb5034ee033fa292cb1ab7a082b57ce2c740b
commit: 98faf436ee05503e258ee934a9de8d8a3472b40f [33/35] ASoC: Drop invalid DMI fields when setting card long name from DMI info


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/soc-core.c:1961:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
