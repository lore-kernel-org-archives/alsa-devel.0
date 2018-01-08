From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 00/10] ASoC: Intel: Kconfig+acpi fixes
Date: Mon, 8 Jan 2018 10:17:15 +0530
Message-ID: <20180108044714.GZ18649@localhost>
References: <20180104223601.5831-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id CDC1926717C
 for <alsa-devel@alsa-project.org>; Mon,  8 Jan 2018 05:43:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180104223601.5831-1-pierre-louis.bossart@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, arnd@arndb.de, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 04, 2018 at 04:35:51PM -0600, Pierre-Louis Bossart wrote:

> Pierre-Louis Bossart (8):
>   ASoC: acpi: add missing includes for non-ACPI platforms
>   ASoC: Intel: Fix Kconfig with top-level selector
>   ASoC: Intel: Kconfig: Simplify-clarify ACPI/PCI dependencies
>   ASoC: Intel: document what Kconfig options do
>   ASoC: Intel: Fix nested/unnecessary Kconfig dependencies
>   ASoC: Intel: boards: align Kconfig dependencies for Haswell/Broadwell
>   ASoC: Intel: boards: align Kconfig configurations for HiFi2
>   ASoC: Intel: boards: align/fix SKL/BXT/KBL Kconfigs

These:

Acked-By: Vinod Koul <vinod.koul@intel.com>

> Vinod Koul (2):
>   ASoC: Intel: kconfig: add some comments for if symbols
>   ASoC: Intel: kconfig: drop boiler plate text from config items

-- 
~Vinod
