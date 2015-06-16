From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: DAPM: fix build errors for missing
 snd_soc_dapm_new_control symbol
Date: Tue, 16 Jun 2015 09:17:50 +0530
Message-ID: <20150616034750.GS28601@localhost>
References: <1434386871-24325-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <20150615165723.GY18309@sirena.org.uk>
 <1434388233.2434.52.camel@loki>
 <20150615182022.GZ18309@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 497AD260705
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 05:46:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150615182022.GZ18309@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 15, 2015 at 07:20:22PM +0100, Mark Brown wrote:
> On Mon, Jun 15, 2015 at 06:10:33PM +0100, Liam Girdwood wrote:
> > On Mon, 2015-06-15 at 17:57 +0100, Mark Brown wrote:
> 
> > > This doesn't apply, I appear to have this already?
> 
> > Oh, ok - Vinod reported it was missing earlier and I could not see it in
> > your topic/topology either ?
> 
> It's a change for DAPM, it's on the DAPM branch.
Sorry for the noise, let me cherry-pick that one for testing.

-- 
~Vinod
