From: kbuild test robot <lkp@intel.com>
Subject: [asoc:for-5.1 98/129]
 sound/soc/codecs/wcd-clsh-v2.c:545:2-3: Unneeded semicolon
Date: Tue, 5 Feb 2019 05:33:25 +0800
Message-ID: <201902050527.kY6FcFFb%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 32B7D267459
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 22:34:12 +0100 (CET)
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
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.1
head:   0f747bb273790f49be4660521d86d7cebd1bbe1e
commit: cc2e324d39b26d62599d056f5cb905a025b909a3 [98/129] ASoC: wcd9335: add CLASS-H Controller support


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/codecs/wcd-clsh-v2.c:545:2-3: Unneeded semicolon
   sound/soc/codecs/wcd-clsh-v2.c:211:2-3: Unneeded semicolon
   sound/soc/codecs/wcd-clsh-v2.c:250:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
