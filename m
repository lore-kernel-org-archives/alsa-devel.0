From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 0/2] ASoC: Intel: ACPI-related fixes
Date: Fri, 12 Jan 2018 09:15:27 +0530
Message-ID: <20180112034526.GK18649@localhost>
References: <20180111195209.5809-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 00813267AEE
 for <alsa-devel@alsa-project.org>; Fri, 12 Jan 2018 04:41:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180111195209.5809-1-pierre-louis.bossart@linux.intel.com>
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
Cc: jeremy@jcline.org, alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 11, 2018 at 01:52:07PM -0600, Pierre-Louis Bossart wrote:
> The first two patches in the v2 series were merged, but these last
> two were not.
> 
> As agreed with Andy and Vinod, there will be a follow-up patch
> to replace snd_soc_acpi_find_name_from_hid() with
> acpi_dev_get_dev_name(), as well as the introduction of a helper
> for the search loops.

Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
