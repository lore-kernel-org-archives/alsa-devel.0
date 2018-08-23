From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm8804: Add ACPI support
Date: Thu, 23 Aug 2018 10:16:46 +0100
Message-ID: <20180823091646.GS32322@imbe.wolfsonmicro.main>
References: <20180823034936.21696-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 85FCB2676D8
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2018 11:16:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180823034936.21696-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.cirrus.com, Keyon Jie <yang.jie@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 22, 2018 at 10:49:36PM -0500, Pierre-Louis Bossart wrote:
> HID made of either Wolfson/CirrusLogic PCI ID + 8804 identifier.
> 
> This helps enumerate the HifiBerry Digi+ HAT boards on the Up2 platform.
> 
> The scripts at https://github.com/thesofproject/acpi-scripts can be
> used to add the ACPI initrd overlays.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---

Looks good to me:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
