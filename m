From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH 1/4] intel_sst: fix comment typo
Date: Thu, 8 Sep 2011 22:17:27 +0100
Message-ID: <CABS+qY2QUV8CCnK3d0n6GXeX36rXmz8ffH4fOctnCzqYgjMwug@mail.gmail.com>
References: <20110906072129.7310.6960.stgit@localhost>
	<438BB0150E931F4B9CE701519A44630108724D8747@bgsmsx502.gar.corp.intel.com>
	<20110907005206.GA7478@guanqun-laptop.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id E8D5B103A53
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Sep 2011 23:17:28 +0200 (CEST)
Received: by mail-qw0-f47.google.com with SMTP id 5so1011831qwh.20
	for <alsa-devel@alsa-project.org>; Thu, 08 Sep 2011 14:17:27 -0700 (PDT)
In-Reply-To: <20110907005206.GA7478@guanqun-laptop.sh.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 7 September 2011 01:52, Lu Guanqun <guanqun.lu@intel.com> wrote:

> On Wed, Sep 07, 2011 at 08:39:06AM +0800, Koul, Vinod wrote:
> > >
> > > Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
> > > Cc: Vinod Koul <vinod.koul@intel.com>
> > > ---
> > >  drivers/staging/intel_sst/intel_sst_dsp.c |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/drivers/staging/intel_sst/intel_sst_dsp.c
> > > b/drivers/staging/intel_sst/intel_sst_dsp.c
> > > index a89e1ad..426d2b9 100644
> > > --- a/drivers/staging/intel_sst/intel_sst_dsp.c
> > > +++ b/drivers/staging/intel_sst/intel_sst_dsp.c
> > > @@ -104,7 +104,7 @@ static int sst_start_mrst(void)
> > >  /**
> > >   * sst_start_medfield - Start the SST DSP processor
> > >   *
> > > - * This starts the DSP in MRST platfroms
> > > + * This starts the DSP in Medfield platfroms
> > >   */
> > >  static int sst_start_medfield(void)
> > >  {
> > All Acked-by: Vinod Koul <Vinod.koul@linux.intel.com>
>
> Thanks.
>
> >
> > You should be CCing Liam as well on asoc patches
>
> I forgot to add Liam, will remember to add for later patches.
>
> >
> > --
> > ~Vinod
> >
>
> --
> guanqun
>

Fine by me.

Acked-by Liam Girdwood <lrg@ti.com>
