From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH 0/5] Intel SST driver restructure
Date: Sat, 14 Mar 2015 06:04:39 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901BD8116@SHSMSX101.ccr.corp.intel.com>
References: <1426170720-8260-1-git-send-email-yang.jie@intel.com>
 <20150313062829.GA32000@intel.com> <55029D8B.9060309@intel.com>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BD7F2C@SHSMSX101.ccr.corp.intel.com>
 <20150313233407.GF28806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A2DD260563
 for <alsa-devel@alsa-project.org>; Sat, 14 Mar 2015 07:04:53 +0100 (CET)
In-Reply-To: <20150313233407.GF28806@sirena.org.uk>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikula,
 Jarkko" <jarkko.nikula@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Jin, Yao" <yao.jin@intel.com>, "Bossart,
 Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Saturday, March 14, 2015 7:34 AM
> To: Jie, Yang
> Cc: Nikula, Jarkko; Koul, Vinod; alsa-devel@alsa-project.org; Girdwood, Liam
> R; Bossart, Pierre-louis; Lin, Mengdong; Jin, Yao
> Subject: Re: [PATCH 0/5] Intel SST driver restructure
> 
> On Fri, Mar 13, 2015 at 02:13:17PM +0000, Jie, Yang wrote:
> 
> > [Keyon] thank you all. Hi Mark, so should I keep them locally and send
> > to you
> > 2 or 3 weeks later, or you will keep them in queue and apply them one day?
> 
> Well, they won't apply as-is since other people are sending patches for the
> files as well.  What might make more sense is to send a script which
> generates the commit (so a bunch of mv commands, patch for the Makefile
> and a changelog entry) then I can do that just before or just after the merge
> window.  Does that make sense?
[Keyon] yes, it make sense. I will prepare these scripts and send to you later.
Thanks.
