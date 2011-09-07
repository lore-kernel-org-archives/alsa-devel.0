From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH 1/4] intel_sst: fix comment typo
Date: Wed, 7 Sep 2011 08:52:06 +0800
Message-ID: <20110907005206.GA7478@guanqun-laptop.sh.intel.com>
References: <20110906072129.7310.6960.stgit@localhost>
	<438BB0150E931F4B9CE701519A44630108724D8747@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 9869F245D0
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Sep 2011 02:51:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A44630108724D8747@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 07, 2011 at 08:39:06AM +0800, Koul, Vinod wrote:
> > 
> > Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
> > Cc: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  drivers/staging/intel_sst/intel_sst_dsp.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/staging/intel_sst/intel_sst_dsp.c
> > b/drivers/staging/intel_sst/intel_sst_dsp.c
> > index a89e1ad..426d2b9 100644
> > --- a/drivers/staging/intel_sst/intel_sst_dsp.c
> > +++ b/drivers/staging/intel_sst/intel_sst_dsp.c
> > @@ -104,7 +104,7 @@ static int sst_start_mrst(void)
> >  /**
> >   * sst_start_medfield - Start the SST DSP processor
> >   *
> > - * This starts the DSP in MRST platfroms
> > + * This starts the DSP in Medfield platfroms
> >   */
> >  static int sst_start_medfield(void)
> >  {
> All Acked-by: Vinod Koul <Vinod.koul@linux.intel.com>

Thanks.

> 
> You should be CCing Liam as well on asoc patches

I forgot to add Liam, will remember to add for later patches.

> 
> --
> ~Vinod
> 

-- 
guanqun
