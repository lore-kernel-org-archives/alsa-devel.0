From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: sst: Intel SST audio driver
Date: Tue, 19 Oct 2010 12:05:38 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104BE811785@bgsmsx502.gar.corp.intel.com>
References: <mailman.1.1287396001.20373.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FCD7103860
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 08:36:19 +0200 (CEST)
In-Reply-To: <mailman.1.1287396001.20373.alsa-devel@alsa-project.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Harsha, Priya" <priya.harsha@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

 
> ... so the whole messages can be reduced to a sentense:
>   "Rewrite the driver based on ASoC!"
> 
> Then it's a question to Intel guys.  If they would like to support for
> it, we can happily wait for it before merging.  If they don't want but
> keep as is, then questions are:
>  - whether to keep it in upstream or not
>  - where to keep it, in staging or in sound tree
> 
> and, the latter question is nothing but a bikeshedding; in anyway it's
> a second choice, after all.  We should spend time for more useful
> things :)

Yes Intel is planning to rewrite the sound card driver for ASoC.
I will take us little time for that :-)

Meanwhile IMO it would be great to have this driver in staging or in sound 
whichever you guys agree to

~Vinod
