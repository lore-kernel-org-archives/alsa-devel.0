From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: cleanup runtime_pm
 initialization
Date: Fri, 21 Nov 2014 08:12:55 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B74356A@SHSMSX101.ccr.corp.intel.com>
References: <1416390207-11020-1-git-send-email-vinod.koul@intel.com>
 <20141119105655.GE22111@sirena.org.uk>
 <F46914AEC2663F4A9BB62374E5EEF8F82B7427B5@SHSMSX101.ccr.corp.intel.com>
 <20141120091208.GF2074@intel.com> <20141120093849.GJ22111@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CDB9265CAC
 for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2014 09:13:12 +0100 (CET)
In-Reply-To: <20141120093849.GJ22111@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Thursday, November 20, 2014 5:39 PM
> 
> On Thu, Nov 20, 2014 at 02:42:08PM +0530, Vinod Koul wrote:
> > On Thu, Nov 20, 2014 at 02:35:33PM +0530, Lin, Mengdong wrote:
> 
> > > Could you tell me where are the two patches in git repo?
> 
> > > I cannot find them on topic/intel branch.
> > > I want to rebase the Cherrytrail/Braswell machine driver on the two
> > > applied patches.
> 
> > I think Mark forgot to push :) don't see update to tree since
> > yesterday
> 
> No, I haven't forgotten.  I've got spotty connectivity since I'm travelling.

Got it. Thanks!

I posted the new v6 Cherrytrail & Braswell patches based on Vinod's patches:
[PATCH v6 1/2] ASoC: Intel: Add Cherrytrail & Braswell machine driver cht_bsw_rt5672
[PATCH v6 2/2] ASoC: Intel: add support for Cherrytrail and Braswell in SST driver

Regards
Mengdong
