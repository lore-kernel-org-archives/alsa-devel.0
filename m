From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: Add Cherrytrail & Braswell
 machine driver cht_bsw_rt5672
Date: Wed, 5 Nov 2014 01:37:33 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B7073BC@SHSMSX101.ccr.corp.intel.com>
References: <c59847b1110e5302ec0a82700d4e318bef2a3f66.1414148860.git.mengdong.lin@intel.com>
 <c716a6624d4227908ee879cbbc9de6d9bca1a0c0.1414495605.git.mengdong.lin@intel.com>
 <20141028164822.GB18557@sirena.org.uk>
 <F46914AEC2663F4A9BB62374E5EEF8F82B702FF6@SHSMSX101.ccr.corp.intel.com>
 <20141029103053.GX18557@sirena.org.uk>
 <F46914AEC2663F4A9BB62374E5EEF8F82B704DC6@SHSMSX101.ccr.corp.intel.com>
 <20141031125415.GA18557@sirena.org.uk>
 <F46914AEC2663F4A9BB62374E5EEF8F82B705DA4@SHSMSX101.ccr.corp.intel.com>
 <F46914AEC2663F4A9BB62374E5EEF8F82B7069B1@SHSMSX101.ccr.corp.intel.com>
 <20141104102310.GG1870@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E195260663
 for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2014 02:38:49 +0100 (CET)
In-Reply-To: <20141104102310.GG1870@intel.com>
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
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "Prusty,
 Subhransu S" <subhransu.s.prusty@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Koul, Vinod
> Sent: Tuesday, November 04, 2014 6:23 PM
> To: Lin, Mengdong
> Cc: Mark Brown; alsa-devel@alsa-project.org; Prusty, Subhransu S; Girdwood,
> Liam R
> Subject: Re: [PATCH v2] ASoC: Intel: Add Cherrytrail & Braswell machine driver
> cht_bsw_rt5672
> 
> On Tue, Nov 04, 2014 at 03:15:15PM +0530, Lin, Mengdong wrote:
> > Hi Mark,
> >
> > I've posted the v3 patch. Would you please have a review?
> >
> > There are other Intel machine drivers submitted at the same time, hope
> > they can be integrated smoothly to avoid conflict on Kconfig and Makefile.
> 
> Mengdong, I am about to send v3 series of my driver changes. Should I add
> this driver in my series to avoid merge conflict in Kconfig?

Okay, please. It will help to avoid merge conflict.

Thanks
Mengdong
